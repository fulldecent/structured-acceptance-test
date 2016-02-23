# Structured Acceptance Test Input

This document is part of the Structured Acceptance Test specification, please see versioning information and details at [the project main page](README.md). *Process* refers to a computer program that supports the Structured Acceptance Test standard.

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMEND, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## Valid input examples

### The simplest valid example

```json
{
}
```

**Here, the process is not provided any targets!** The process MUST decide whether this results in a `pass` or `fail` outcome.

This example is useful because it is the simplest way to cause a process to output its identification. (See the [STAT Output / identification part specification](Stat-Output.md#the-identification-part) for details.)

### Full-featured example

```json
{
  "targetPaths": [
    "code/"
  ],
  "pathFilters": [
    {"pattern": "*.txt", "include": false},
    {"pattern": "Readme.txt", "include": true}
  ]
}
```

In this example, a file `code/Readme.txt` would be tested, but `code/Version.txt` would not.

## Full specification

The input is a single object which is formatted in [JSON](http://www.json.org/).

```json
{
  "targetPaths": [String],
  "pathFilters": [PathFilter]
}
```

* `targetPaths` &mdash; **Optional** &mdash; Each path is a file or directory that the acceptance test MAY consider; if omitted then `[]` is used
* `pathFilters` &mdash; **Optional** &mdash; Filters that will apply to each `targetPath`; if omitted then `[]` is used

Each path in `targetPaths` MUST be either an absolute or relative file path and MUST represent a file or directory.

**CODE CLIMATE NOTE: `targetPaths` MUST be `[code/]; `**

**CODE CLIMATE NOTE: if `pathFilters` is specified then the first must be `{"pattern":"*", "include":false}` and others must have `include` be `true`**

### PathFilter

```json
{
  "pattern": String,
  "include": Boolean
}
```

* `pattern` &mdash; **Required** &mdash; The pattern description (see details below)
* `include` &mdash; **Required** &mdash; `true` if this pattern should include paths; or `false` if it should exclude paths

#### Pattern Evaluation

*Note: this is based on the [`gitignore` documentation's pattern format](https://git-scm.com/docs/gitignore#_pattern_format).*

*Note: it may be possible to use the `git` command line tools to apply these path filters, see https://stackoverflow.com/questions/35510871/can-i-use-gits-ignore-processing-outside-of-git*

 * Every `PathFilter` `pattern`s is evaluated for every `targetPaths` entry.

 * The last matching pattern decides the outcome.

 * Note: it is possible that a `PathFilter` may cause a *file* `targetPaths` entry to be excluded.

 * If the outcome is that a file or directory should be excluded then the process MUST NOT report any findings for that file. (See the [STAT Output specification](Stat-Output.md) for details on findings.)

#### Pattern Descriptions

 * If the pattern ends with a slash, it is removed for the purpose of the following description, but it would only find a match with a directory. In other words, foo/ will match a directory foo and paths underneath it, but will not match a regular file or a symbolic link foo (this is consistent with the way how pathspec works in general in Git).

 * If the pattern does not contain a slash /, it SHALL be treated as a shell glob pattern and checks for a match against the pathname relative to the location of the .gitignore file (relative to the toplevel of the work tree if not from a .gitignore file).

 * Otherwise, the pattern is treated as a shell glob suitable for consumption by [fnmatch(3)](http://man7.org/linux/man-pages/man3/fnmatch.3.html) with the `FNM_PATHNAME` flag: wildcards in the pattern will not match a / in the pathname. For example, "`Documentation/*.html`" matches "`Documentation/git.html`" but not "`Documentation/ppc/ppc.html`" or "`tools/perf/Documentation/perf.html`".

 * A leading slash matches the beginning of the pathname. For example, "`/*.c`" matches "`cat-file.c`" but not "`mozilla-sha1/sha1.c`".

Two consecutive asterisks ("`**`") in patterns matched against full pathname may have special meaning:

 * A leading "`**`" followed by a slash means match in all directories. For example, "`**/foo`" matches file or directory "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`" matches file or directory "`bar`" anywhere that is directly under directory "`foo`".

 * A trailing "`/**`" matches everything inside. For example, "`abc/**`" matches all files inside directory "`abc`", relative to the location of the `TARGETPATH`, with infinite depth.

 * A slash followed by two consecutive asterisks then a slash matches zero or more directories. For example, "`a/**/b`" matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.

 * Other consecutive asterisks are considered invalid. They MUST cause an error (see ERROR REPORTING in the [output file specification](Stat-Output.md) for details).
