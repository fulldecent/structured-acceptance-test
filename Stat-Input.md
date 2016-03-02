# Structured Acceptance Test Input

This document is part of the Structured Acceptance Test specification, please see versioning information and details at [the project main page](README.md). *Process* refers to a computer program that supports the Structured Acceptance Test standard.

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMEND, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## Valid input examples

### The simplest valid example

```json
{
}
```

**Here, the *process* is not provided any targets!** The *process* MUST decide whether this results in a `pass` or `fail` outcome.

This example is useful because it causes the *process* to output its identification. (See the [STAT Output / identification part specification](Stat-Output.md#identification) for details.)

### Full-featured example

```json
{
  "targetPaths": [
    "/code/mainTarget/",
    "/code/otherTarget/config.txt"
  ]
}
```

In this example, a file `/code/mainTarget/hello.txt` would be selected, but `/code/otherTarget/hello.txt` would not.

## Full specification

The input is a single object which is formatted in [JSON](http://www.json.org/).

```json
{
  "targetPaths": [String]
}
```

* `targetPaths` &mdash; **Optional** &mdash; Each path is a file or directory that the acceptance test MAY consider; if omitted then `[]` is used

Each path in `targetPaths` MUST be either an absolute or relative file path. Directories MUST end with a training slash (`/`). The *process* MAY consider any file target or the recursive contents of any directory target. The *process* MUST NOT consider other files.

**CODE CLIMATE NOTE: each path must begin exactly with `/code/`**

 ### Extensibility

 The object in this specification may have extra keys introduced for the *process* to consider. The *process* MUST ignore any additional information it does not understand. The `failure` key is reserved and may not be used in extensions.
