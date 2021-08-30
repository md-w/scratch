load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_binary(
    name = "cpp-protobuf",
    srcs = glob(
        ["src/*.cpp"],
        exclude = ["src/gtest-all.cpp"],
    ),
    includes = ["inc"],
    deps = [
        "//utils:cpp-utils",
        "@com_google_benchmark//:benchmark",
    ],
)
