# Structured Acceptance Test Input

This document is part of the Structured Acceptance Test specification. Please see versioning information and details at [the project main page](README.md).

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMEND, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## Valid input examples

### The simplest valid example

    {
    }

*In this case, the acceptance test is instructed not to do anything! The test will then provide

If `TARGETPATHS` is not specified, then the acceptance test MUST still produce valid output. That output MAY include useful information about the test (version number, assumptions). (See the [output file specification](Stat-Output.md) for details.)


### Full-featured example

    {
      "targetPaths": [
        "code/"
      ],
      "pathFilters": [
        {"pattern": "*.txt", "include": false},
        {"pattern": "Readme.txt", "include": true}
      ]
    }

Note: in this example, the file `code/Readme.txt` would be tested, but `code/Version.txt` would not.

## Full specification

| Name              | Type                   | REQUIRED | Description                                                            |
|-------------------|------------------------|----------|------------------------------------------------------------------------|
| `targetPaths`     | array of strings       | no       | Each path is a file or directory that the acceptance test MAY consider |
| `pathFilters`     | array of `pathFilters` | no       | Each filter is a rule that MAY restrict each `TARGETPATH`              |

If `TARGETPATHS` is not specified, then the acceptance test MUST still produce valid output. That output MAY include useful information about the test (version number, assumptions). (See the [output file specification](Stat-Output.md) for details.)

The 'TARGETPATHS' may be absolute or relative paths. And they may represent files or directories.

### Path Filters

| Name      | Type              | REQUIRED | Description                                                                    |
|-----------|-------------------|----------|--------------------------------------------------------------------------------|
| `pattern` | string            | yes      | The pattern description (see below)                                            |
| `include` | `true` or `false` | yes      | Whether this pattern should include files (`true`) or excludes files (`false`) |

### Pattern Evaluation

*Note: this is based on the "Pattern Format" rules defined in the [gitignore documentation](https://git-scm.com/docs/gitignore).*

*Note: it may be possible to use the `git` command line tools to apply these path filters, see https://stackoverflow.com/questions/35510871/can-i-use-gits-ignore-processing-outside-of-git*

 * All `PATHFILTER` `PATTERNS` are evaluated for each `TARGETPATH`

 * The last matching pattern decides the outcome

 * Note: it is possible that `PATHFILTER`s may cause a file `TARGETPATH` to be excluded

 * If the outcome is that a file or directory should be excluded then the Acceptance Test MUST NOT report any findings for that file

### Pattern Descriptions

 * If the pattern ends with a slash, it is removed for the purpose of the following description, but it would only find a match with a directory. In other words, foo/ will match a directory foo and paths underneath it, but will not match a regular file or a symbolic link foo (this is consistent with the way how pathspec works in general in Git).

 * If the pattern does not contain a slash /, it SHALL be treated as a shell glob pattern and checks for a match against the pathname relative to the location of the .gitignore file (relative to the toplevel of the work tree if not from a .gitignore file).

 * Otherwise, Git treats the pattern as a shell glob suitable for consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards in the pattern will not match a / in the pathname. For example, "`Documentation/*.html`" matches "`Documentation/git.html`" but not "`Documentation/ppc/ppc.html`" or "`tools/perf/Documentation/perf.html`".

 * A leading slash matches the beginning of the pathname. For example, "`/*.c`" matches "`cat-file.c`" but not "`mozilla-sha1/sha1.c`".

Two consecutive asterisks ("`**`") in patterns matched against full pathname may have special meaning:

 * A leading "`**`" followed by a slash means match in all directories. For example, "`**/foo`" matches file or directory "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`" matches file or directory "`bar`" anywhere that is directly under directory "`foo`".

 * A trailing "`/**`" matches everything inside. For example, "`abc/**`" matches all files inside directory "`abc`", relative to the location of the `TARGETPATH`, with infinite depth.

 * A slash followed by two consecutive asterisks then a slash matches zero or more directories. For example, "`a/**/b`" matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.

 * Other consecutive asterisks are considered invalid. They MUST cause an error (see ERROR REPORTING in the [output file specification](Stat-Output.md) for details).
