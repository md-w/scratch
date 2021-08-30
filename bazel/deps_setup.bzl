load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def urlsplit(url):
    """ Splits a URL like "https://example.com/a/b?c=d&e#f" into a tuple:
        ("https", ["example", "com"], ["a", "b"], ["c=d", "e"], "f")
    A trailing slash will result in a correspondingly empty final path component.
    """
    split_on_anchor = url.split("#", 1)
    split_on_query = split_on_anchor[0].split("?", 1)
    split_on_scheme = split_on_query[0].split("://", 1)
    if len(split_on_scheme) <= 1:  # Scheme is optional
        split_on_scheme = [None] + split_on_scheme[:1]
    split_on_path = split_on_scheme[1].split("/")
    return {
        "scheme": split_on_scheme[0],
        "netloc": split_on_path[0].split("."),
        "path": split_on_path[1:],
        "query": split_on_query[1].split("&") if len(split_on_query) > 1 else None,
        "fragment": split_on_anchor[1] if len(split_on_anchor) > 1 else None,
    }

def auto_http_archive(
        *,
        name = None,
        url = None,
        urls = True,
        build_file = None,
        build_file_content = None,
        strip_prefix = True,
        **kwargs):
    """ Intelligently choose mirrors based on the given URL for the download.
    Either url or urls is required.
    If name         == None , it is auto-deduced, but this is NOT recommended.
    If urls         == True , mirrors are automatically chosen.
    If build_file   == True , it is auto-deduced.
    If strip_prefix == True , it is auto-deduced.
    """
    DOUBLE_SUFFIXES_LOWERCASE = [("tar", "bz2"), ("tar", "gz"), ("tar", "xz")]
    mirror_prefixes = ["https://mirror.bazel.build/"]

    canonical_url = url if url != None else urls[0]
    url_parts = urlsplit(canonical_url)
    url_except_scheme = (canonical_url.replace(url_parts["scheme"] + "://", "") if url_parts["scheme"] != None else canonical_url)
    url_path_parts = url_parts["path"]
    url_filename = url_path_parts[-1]
    url_filename_parts = (url_filename.rsplit(".", 2) if (tuple(url_filename.lower().rsplit(".", 2)[-2:]) in
                                                          DOUBLE_SUFFIXES_LOWERCASE) else url_filename.rsplit(".", 1))
    is_github = url_parts["netloc"] == ["github", "com"]

    if name == None:  # Deduce "com_github_user_project_name" from "https://github.com/user/project-name/..."
        name = "_".join(url_parts["netloc"][::-1] + url_path_parts[:2]).replace("-", "_")

    if build_file == True:
        build_file = "@//%s:%s" % ("bazel", "BUILD." + name)

    if urls == True:
        prefer_url_over_mirrors = is_github
        urls = [
            mirror_prefix + url_except_scheme
            for mirror_prefix in mirror_prefixes
            if not canonical_url.startswith(mirror_prefix)
        ]
        urls.insert(0 if prefer_url_over_mirrors else len(urls), canonical_url)
    else:
        print("No implicit mirrors used because urls were explicitly provided")

    if strip_prefix == True:
        prefix_without_v = url_filename_parts[0]
        if prefix_without_v.startswith("v") and prefix_without_v[1:2].isdigit():
            # GitHub automatically strips a leading 'v' in version numbers
            prefix_without_v = prefix_without_v[1:]
        strip_prefix = (url_path_parts[1] + "-" + prefix_without_v if is_github and url_path_parts[2:3] == ["archive"] else url_filename_parts[0])

    return http_archive(
        name = name,
        url = url,
        urls = urls,
        build_file = build_file,
        build_file_content = build_file_content,
        strip_prefix = strip_prefix,
        **kwargs
    )

def deps_setup():
    # Explicitly bring in protobuf dependency to work around
    # https://github.com/ray-project/ray/issues/14117
    auto_http_archive(
        name = "com_google_protobuf",
        strip_prefix = "protobuf-3.17.3",
        urls = ["https://github.com/protocolbuffers/protobuf/archive/v3.17.3.tar.gz"],
        sha256 = "c6003e1d2e7fefa78a3039f19f383b4f3a61e81be8c19356f85b6461998ad3db",
    )

    auto_http_archive(
        name = "com_github_spdlog",
        build_file = "//bazel:spdlog.BUILD",
        urls = ["https://github.com/gabime/spdlog/archive/v1.9.2.zip"],
        sha256 = "130bd593c33e2e2abba095b551db6a05f5e4a5a19c03ab31256c38fa218aa0a6",
    )

    http_archive(
        name = "com_google_benchmark",
        strip_prefix = "benchmark-1.5.6",
        urls = ["https://github.com/google/benchmark/archive/refs/tags/v1.5.6.zip"],
        sha256 = "03ddc88d9f381b056bc742592fb46cea11600329ecc7c9604618cdca438adee6",
    )

    http_archive(
        name = "com_google_benchmark",
        strip_prefix = "benchmark-1.5.6",
        urls = ["https://github.com/google/benchmark/archive/refs/tags/v1.5.6.zip"],
        sha256 = "03ddc88d9f381b056bc742592fb46cea11600329ecc7c9604618cdca438adee6",
    )

    http_archive(
        name = "com_google_absl",
        strip_prefix = "abseil-cpp-20210324.2",
        urls = ["https://github.com/abseil/abseil-cpp/archive/refs/tags/20210324.2.zip"],
        sha256 = "1a7edda1ff56967e33bc938a4f0a68bb9efc6ba73d62bb4a5f5662463698056c",
    )

    http_archive(
        name = "com_google_googletest",
        strip_prefix = "googletest-release-1.11.0",
        urls = ["https://github.com/google/googletest/archive/refs/tags/release-1.11.0.zip"],
        sha256 = "353571c2440176ded91c2de6d6cd88ddd41401d14692ec1f99e35d013feda55a",
    )
