load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_binary(
    name = "cpp",
    srcs = [
        "cpp_benchmark.cc",
    ],
    tags = ["benchmark"],
    deps = [
        "//benchmarks:benchmarks_cc_proto",
        "//benchmarks/datasets:cc_protos",
        "//utils:cpp-utils",
        # "@com_google_protobuf//:protobuf",
        "@com_google_benchmark//:benchmark_main",
    ],
)
