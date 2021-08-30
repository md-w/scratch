load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

# load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")

# _ALL_CONTENT = """\
# filegroup(
#     name = "all_srcs",
#     srcs = glob(["**"]),
#     visibility = ["//visibility:public"],
# )
# """
# cc_library(
#     name = "hello-greet",
#     srcs = ["hello-greet.cc"],
#     hdrs = ["hello-greet.h"],
# )

# cmake(
#     name = "spdlog",
#     # cache_entries = {
#     #     "CMAKE_C_FLAGS": "-fPIC",
#     # },
#     lib_source = "@com_gabime_spdlog",
#     # out_static_libs = ["libpcre.a"],
# )

cc_binary(
    name="cpp-protobuf",
    srcs=glob(["src/*.cpp"], exclude=["src/gtest-all.cpp"]),
    includes=["inc"],
    # hdrs = glob([
    #     "inc/**/*.h",
    #     "src/*.h"
    # ]),
    deps=[
        "@com_google_benchmark//:benchmark",
        "//utils:cpp-utils",
    ],
)
