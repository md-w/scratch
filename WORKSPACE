# load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# git_repository(
#     name = "com_google_benchmark",
#     remote = "https://github.com/google/benchmark.git",
#     tag = "v1.5.6",
# )

load("//bazel:deps_setup.bzl", "deps_setup")

deps_setup()

load("//bazel:deps_build_all.bzl", "deps_build_all")

deps_build_all()
