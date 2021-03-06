/**
 * Demo for using Benchmarking using Google's benchmark platform:
 * Run:
         bazel run //cpp-protobuf/main:cpp-protobuf -c opt -- --benchmark_format=csv | \
         tee src/benchmark/outputs/main_benchmark.csv
         python3 src/benchmark/plot.py src/benchmark/outputs/main_benchmark.csv
    //https://shanee.io/blog/2019/05/28/bazel-with-visual-studio-code/
 */
#include "benchmark/benchmark.h"

#include <chrono>
#include <string>

void SomeFunction(size_t size)
{
    std::string s1(size, '-');
    std::string s2(size, '-');
    benchmark::DoNotOptimize(s1.compare(s2));
}

static void BM_SomeFunction(benchmark::State &state)
{
    // Perform setup here
    for (auto _ : state)
    {
        // This code gets timed
        SomeFunction(state.range(0));
    }
}
// Register the function as a benchmark
// BENCHMARK(BM_SomeFunction)->Arg(100000)->Arg(200000)->Arg(400000);

BENCHMARK(BM_SomeFunction)->RangeMultiplier(2)->Range(1 << 10, 1 << 20);

// Run the benchmark
BENCHMARK_MAIN();