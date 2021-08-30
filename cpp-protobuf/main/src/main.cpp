#include "benchmark/benchmark.h"
#include "logging.h"
#include <fstream>
#include <iostream>

#include <chrono>
#include <string>

std::string ReadFile(const std::string &name)
{
    std::ifstream file(name.c_str());
    RAY_CHECK(file.is_open()) << "Couldn't find file '" << name << "', please make sure you are running "
                                                                   "this command from the benchmarks/ "
                                                                   "directory.\n";

    return std::string((std::istreambuf_iterator<char>(file)),
                       std::istreambuf_iterator<char>());
}

void RegisterBenchmarks(const std::string &dataset_bytes)
{
}

// Run the benchmark
int main(int argc, char **argv)
{
    ::ray::RayLog::StartRayLog("aa", ::ray::RayLogLevel::DEBUG, "");
    ::benchmark::Initialize(&argc, argv);
    // if (::benchmark::ReportUnrecognizedArguments(argc, argv))
    //     return 1;
    if (argc == 1)
    {
        std::cerr << "Usage: ./cpp-protobuf <input data>" << std::endl;
        std::cerr << "input data is in the format of \"benchmarks.proto\""
                  << std::endl;
        return 1;
    }
    else
    {
        for (int i = 1; i < argc; i++)
        {
            RegisterBenchmarks(ReadFile(argv[i]));
        }
    }

    ::benchmark::RunSpecifiedBenchmarks();
    ::benchmark::Shutdown();
    ::ray::RayLog::ShutDownRayLog();
    return 0;
}