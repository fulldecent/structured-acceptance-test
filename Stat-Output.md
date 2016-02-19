# Structured Acceptance Test Output

This document is part of the Structured Acceptance Test specification. Please see versioning information and details at [the project main page](README.md).

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMEND, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## Valid output examples

The output format consists of:

 * One required "header" part which identifies the acceptance test; and
 * Zero or more "finding" parts which describe a specific problem

Each part MUST be delimited by a new line. An acceptance test MUST choose between Unix-style line endings ("`\n`") and DOS-style line endings ("`\r\n`"). A report consumer MUST accept either format. This is the [Concatenated JSON](https://en.wikipedia.org/wiki/JSON_Streaming) format.

*Please note: a program that supports Structured Acceptance Test SHOULD output each finding as it is found. This allows another program to interpret these findings incrementally.*

### The simplest valid example

```json
{
  "statVersion": "0.1.0",
  "name": "Vowel grep"
}
```

*This example indicates that an acceptance test named "Vowel grep" was applied to the requested targets, if any, and no findings were reported. Also, a lack of any findings implies that the acceptance test has passed.*

FIXME: HOW TO KNOW WHICH FILES WERE CONSIDERED?

### Full-featured example

```json
{
  "statVersion": "0.1.0",
  "name": "Vowel grep",
  "version": "0.1.0",
  "description": "Ensures that no a's, e's, i's, o's or u's are found",
}
{
  "failure": true,
  "rule": "Bug Risk/Unused Variable",
  "description": "Unused local variable `foo`",
  "content": Content,
  "categories": ["Complexity"],
  "location": Location,
  "otherLocations": [Location],
  "remediation_points": 50000,
  "severity": Severity,
  "repeatability": Repeatability
}
```


## Full specification

[REWORD] Engines stream static analysis Issues to STDOUT in JSON format. When possible, results should be emitted as soon as they are computed (streaming, not buffered). Each issue is terminated by the null character (\0 in most programming languages), but can additionally be separated by newlines.

[REWORD] Unstructured information can be printed on STDERR for the purposes of aiding debugging. Note that STDERR output will only be displayed in the console output when there is a failure, so this approach may not be appropriate for general purpose logging.

[REWORD] An engine must exit with a zero exit code to be considered a success. Any nonzero exit code indicates a fatal error in the static analysis and the results for the entire analysis will be discarded (even if some were previously emitted).

### The header part

```json
{
  "statVersion": String,
  "name": String,
  "version": String,
  "description": String,
  "maintainer": String,
  "email": String,
  "website": String,
  "repeatability": Repeatability
}
```

 * `statVersion` &mdash; **Required** &mdash; The version of Structured Acceptance Test with which this report complies
 * `name` &mdash; **Required** &mdash; Identification of the process which is performing validation
   * For automated tools, this MUST be the name of the tool
   * For manual review, this SHOULD refer to the name of the test and validation procedure performed
 * `version` &mdash; **Optional** &mdash; The version of the validation process program or test procedure
 * `description` &mdash; **Optional** &mdash; A brief explanation of the validation process
 * `maintainer` &mdash; **Optional** &mdash; The name of a person responsible for the validation process
 * `email` &mdash; **Optional** &mdash; Contact email address for the maintainer
 * `website` &mdash; **Optional** &mdash; Contact website for the validation process
 * `repeatability` &mdash; **Optional** &mdash; *See repeatability below*

**CODE CLIMATE NOTE: all fields are required except repeatability**

#### Repeatability

Repeatability is a guarantee that the same validation results would occur in the future if applied to the same, or a similar set of targets. Because validation may be expensive, this will allow certain validations to be skipped in the future.

A report consumer MUST NOT consider a guarantee from one validation `name` and `version` to be valid with a different one.

Repeatability must be one of the following strings:

 * `Volatile` -- validations MAY change when repeating validation on the identical targets. Example: a web link checker, or package manager version checker. **This is the implicit default if not specified.**
 * `Repeatable` -- if the same set of targets is provided, the validation results are guaranteed to be identical
 * `Associative` -- the validation result of targets [a, b] is guaranteed to be the sum of validation for [a] and [b] -- in other words, if only one file in changed, only that file need be tested

### The finding part

```json
{
  "failure": Bool,
  "rule": String,
  "description": String,
  "detail": Detail,
  "categories": [Category],
  "location": Location,
  "timeToFix": Number,
  "recommendations": [Recommendation]
}
```

* `failure` &mdash; **Required** &mdash; `true` if this finding causes the target to fail the overall acceptance test; `false` otherwise
* `rule` &mdash; **Required** &mdash; A succinct name which describes the rule which applies to this finding
* `description` &mdash; **Required** &mdash; An explanation of the finding
* `detail` &mdash; **Optional** &mdash; *See Detail below*
* `categories` &mdash; **Optional** &mdash; *See Category below*
* `location` &mdash; **Optional** &mdash; *See Location below*
* `timeToFix` &mdash; **Optional** &mdash; The estimated amount of time it would take a knowledgable human to fix this problem, in seconds
* `recommendations` &mdash; **Optional** &mdash; *See Recommendation below*

#### Detail

```json
{
  "body": String,
  "trace": [Location]
}
```

 * `detail` &mdash; **Required** &mdash; A markdown-formatted, detailed explanation the finding, which may include links to further information
 * `trace` &mdash; **Optional** &mdash; An ordered list of `Location`s which provide context to the finding, with the first being the most closely related

#### Category

Category is a string that classifies the finding into a taxonomy. The taxonomy is not yet defined.

**CODE CLIMATE NOTE: Only the following categories are allowed and they have the meaning shown below.**

 * `Bug Risk` &mdash; the meaning is likely to not be what the author intended
   * Code example: `if (a = 5)`, the author may have meant `==`
   * Non-code example: `I like there music`, the author probably meant `their`
 * `Clarity` &mdash; the meaning is unclear
   * Code example: `a = ++x--`
   * Non-code example: `I, to see a friend, am going town.`
 * `Compatibility` &mdash; the meaning has changed and is no longer valid
   * Code example: using `UIAlertView` in iOS 9
   * Non-code example: an Excel XLSX file, if only XLS is allowed
 * `Complexity` &mdash; the meaning should be broken into smaller pieces
   * Code example: a four-page long function
   * Non-code example: a flowchart with lines much longer than they must be
 * `Duplication` &mdash; unnecessary duplication was found
   * Code example: something that violates DRY principle
   * Non-code example: two images in a directory are identical
 * `Performance` &mdash; an inefficient approach was used
   * Code example: `for (i=0; i<1000000; count+=1)`
   * Non-code example: *I can't think of one*
 * `Security` &mdash; a situation may allow access to something that should be allowed
   * Code example: `echo $_POST['name']`
   * Non-code example: `... or you can use _NSAKEY to sign the binary`
 * `Style` &mdash; the style could be improved
   * Code example: `if ((((((a == (((5)))))))))`
   * Non-code example: an image uses colors inconsistent with style guide

#### Location

*Note: location is optional but SHOULD be provided. If it is not provided then the finding applies to the entirety of all targets. An example would be a customer who complains "it is OK but it needs more UMPH." Such a validation and finding is a valid complaint which can be properly represented in the STAT format.*

```json
{
  "path": String,
  "beginLine": Number,
  "beginColumn": Number,
  "endLine": Number,
  "endColumn": Number
}
```

* `path` &mdash; **Required** &mdash; The file path which this finding refers to, which MUST begin exactly with one of the `targetPaths` from the validation input
* `beginLine` &mdash; **Optional** &mdash; The first line of text affected (numbering starts with one), defaults to one
* `beginColumn` &mdash; **Optional** &mdash; The first column of text affected (numbering starts with one), defaults to one
* `endColumn` &mdash; **Optional** &mdash; The last column of text affected (numbering starts with one), defaults to the last
* `endLine` &mdash; **Optional** &mdash; The last line of text affected (numbering starts with one), defaults to the last

Note: if `beginLine` and `endLine` are both `1`, then the columns are to be interpreted as byte offsets (still one-based). For example, a WAVE sound file containing `riff` at the beginning (it should be `RIFF`) would be identified by the location:

    {"path":file,"beginLine":1,"beginColumn":1,"endLine":1,"endColumn":4}

#### Recommendation

A `recommendation` is a proposed way to fix a finding.

```json
{
  "correction": String,
  "location": Location,
  "replacement": String
}
```

* `correction` &mdash; **Required** &mdash; Explanation on an act, using imperative language (eg. "Add a semicolon", "Use the passive voice"), which would fix this finding.
* `location` &mdash; **Optional** &mdash; A certain section of a targeted file
* `replacement` &mdash; **Optional** &mdash; New text which is proposed to replace the section from `location`

If `replacement` is provided then `location` MUST be provided.

### Extensibility

New keys MAY be added by the validation process to extend any object with proprietary information. The report consumer MUST ignore such additional information it does not understand.
