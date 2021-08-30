# load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# git_repository(
#     name = "com_google_benchmark",
#     remote = "https://github.com/google/benchmark.git",
#     tag = "v1.5.6",
# )

# load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# http_archive(
#     name = "rules_foreign_cc",
#     sha256 = "33a5690733c5cc2ede39cb62ebf89e751f2448e27f20c8b2fbbc7d136b166804",
#     strip_prefix = "rules_foreign_cc-0.5.1",
#     url = "https://github.com/bazelbuild/rules_foreign_cc/archive/0.5.1.tar.gz",
# )

# load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

# # This sets up some common toolchains for building targets. For more details, please see
# # https://bazelbuild.github.io/rules_foreign_cc/0.5.1/flatten.html#rules_foreign_cc_dependencies
# rules_foreign_cc_dependencies()

# git_repository(
#     name = "com_gabime_spdlog",
#     remote = "https://github.com/gabime/spdlog.git",
#     tag = "v1.9.2",
#     # build_file_content = _ALL_CONTENT,
#     # strip_prefix = "pcre-8.43",
# )

load("//bazel:deps_setup.bzl", "deps_setup")

deps_setup()

load("//bazel:deps_build_all.bzl", "deps_build_all")

deps_build_all()