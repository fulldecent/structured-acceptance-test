# Structured Acceptance Test Output

This document is part of the Structured Acceptance Test specification, please see versioning information and details at [the project main page](README.md). *Process* refers to a computer program that supports the Structured Acceptance Test standard. *Consumer* refers to something that uses the output of the *process*.

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMEND, MAY, and OPTIONAL in this document are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## Valid output examples

### The simplest valid example

```json
{
  "statVersion": "0.4.0",
  "process": {
    "name": "Vowel grep"    
  }
}
```

This example identifies an acceptance test named "Vowel grep" and does not express any findings. A `pass` outcome is implied.

### Full-featured example

```json
{
  "statVersion": "0.4.0",
  "process": {
    "name": "Vowel grep",
    "version": "0.1.0",
    "description": "Ensures that no a's, e's, i's, o's or u's are found",
    "maintainer": "William Entriken",
    "email": "github.com@phor.net",
    "website": "https://github.com/fulldecent/structured-acceptance-test/tree/master/Examples",
    "repeatability": "Associative"
  },
  "findings": [
    {
      "failure": true,
      "rule": "Vowel used",
      "description": "Letter a was used",
      "detail": {
        "body": "Don't use `a` because only consonants are allowed."
      },
      "categories": [
        "Style"
      ],
      "location": {
        "path": "code\/hello.txt",
        "beginLine": 1,
        "beginColumn": 2,
        "endLine": 1,
        "endColumn": 2
      },
      "timeToFix": 60,
      "recommendation": "Replace this with an X",
      "fixes": [
        {
          "location": {
            "path": "code\/hello.txt",
            "beginLine": 1,
            "beginColumn": 2,
            "endLine": 1,
            "endColumn": 2
          },
          "newText": "X"
        }
      ]
    }
  ]
}
```

This example shows the partial output of a *process* that disallows vowels being applied to a file containing "hello world".

## Full specification

The output is a [JSON-formatted](http://www.json.org/) object containing a **Process** object and zero or more **Finding** objects.

```json
{
  "statVersion": "0.4.0",
  "process": Process,
  "findings": [Finding]
}
```

* `statVersion` &mdash; **Required** &mdash; The version of Structured Acceptance Test against which this output is valid
* `process` &mdash; **Required** &mdash; Identification of the *process* which is doing testing
* `findings` &mdash; **Optional** &mdash; A set of observations reported by the *process*, or `[]` if not specified

Each finding SHOULD be delimited by a new line. A computer program with STAT-compliant output SHOULD immediately output each finding as available (e.g. use `flush()`). This allows the `consumer` to begin processing the results right away.

A *consumer* should ignore the entire STAT Output if it is not valid JSON. This may occur, for example, if the *process* was interrupted or had an internal error.

A STAT-compliant computer program MUST produce STAT-compliant output on STDOUT and MUST exit with a return status of zero if no *failure* *findings* were reported, or non-zero otherwise.

### Process

```json
{
  "name": String,
  "version": String,
  "description": String,
  "maintainer": String,
  "email": String,
  "website": String,
  "repeatability": Repeatability
}
```

 * `name` &mdash; **Required** &mdash; Identification of the acceptance test *process*
   * For automated tools, this MUST be the name of the tool
   * For manual review, this SHOULD refer to the name of the test and validation procedure performed
 * `version` &mdash; **Optional** &mdash; The version of the acceptance test *process*
 * `description` &mdash; **Optional** &mdash; A brief explanation of the acceptance test *process*
 * `maintainer` &mdash; **Optional** &mdash; The name of a person responsible for the acceptance test *process*
 * `email` &mdash; **Optional** &mdash; Contact email address for the maintainer
 * `website` &mdash; **Optional** &mdash; Contact website for the acceptance test *process*
 * `repeatability` &mdash; **Optional** &mdash; A guarantee of whether the same validation output can be expected in future validation, see notes below

**CODE CLIMATE NOTE: everything is required except repeatability**

#### Repeatability

Repeatability is a guarantee that the same output MUST occur if the test is applied again to the same, or a similar set of targets. Because validation MAY be expensive, this will allow certain validations to be skipped in the future.

A *consumer* MUST NOT consider a repeatability guarantee from one validation `name` and `version` to be valid with another.

Repeatability MUST be one of the following strings:

 * `Volatile` &mdash; Findings MAY change when repeating validation on the identical targets. Example: a web link checker, or package manager version checker. **This is the implicit default if not specified.**
 * `Repeatable` &mdash; Findings MUST be identical if the program is run again with the same inputs. ("Inputs" is not specified by this standard.)
 * `Associative` &mdash; Findings for targets [a, b] MUST equal the union of findings for [a] and [b] -- in other words, if only one file in changed, only that file need be tested.

Note: `Associative` is the strongest and most useful guarantee.

### Finding

```json
{
  "failure": Bool,
  "rule": String,
  "description": String,
  "detail": Detail,
  "categories": [Category],
  "location": Location,
  "timeToFix": Number,
  "recommendation": String,
  "fixes": [Fix]
}
```

* `failure` &mdash; **Required** &mdash; `true` if this finding causes the output to be `fail`; `false` otherwise
* `rule` &mdash; **Required** &mdash; A succinct name which describes the rule which applies to this finding
* `description` &mdash; **Required** &mdash; An explanation of the finding
* `detail` &mdash; **Optional** &mdash; See *Detail* below
* `categories` &mdash; **Optional** &mdash; See *Category* below
* `location` &mdash; **Optional** &mdash; See *Location* below
* `timeToFix` &mdash; **Optional** &mdash; The estimated amount of time it would take a knowledgable human to fix this problem, in seconds
* `recommendation` &mdash; **Optional** &mdash; Explanation of an act, using imperative language (eg. "Add a semicolon", "Use the passive voice"), which would fix this finding
* `fixes` &mdash; **Optional** &mdash; See *Fix* below

**CODE CLIMATE NOTE: categories and location are required**

*File progress* MAY be reported by setting `rule` to "`Progress`" and setting `description` to `done`. This allows the *process* to communicate each file that was considered and the overall status.

#### Detail

```json
{
  "body": String,
  "trace": [Location]
}
```

 * `body` &mdash; **Required** &mdash; A markdown-formatted, detailed explanation the finding, which may include links to further information
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

```json
{
  "path": String,
  "beginLine": Number,
  "beginColumn": Number,
  "endLine": Number,
  "endColumn": Number
}
```

* `path` &mdash; **Required** &mdash; The file path to which this finding applies
* `beginLine` &mdash; **Optional** &mdash; The first line of text affected (numbering starts with one), defaults to one
* `beginColumn` &mdash; **Optional** &mdash; The first column of text affected (numbering starts with one), defaults to one
* `endColumn` &mdash; **Optional** &mdash; The last column of text affected (numbering starts with one), defaults to the last
* `endLine` &mdash; **Optional** &mdash; The last line of text affected (numbering starts with one), defaults to the last

Note: if `beginLine` and `endLine` are both `1`, then `beginColumn` and `endColumn` SHALL represent byte offsets (still one-based). For example, a WAVE sound file containing `riff` at the beginning (it should be `RIFF`) would be identified by the location:

    {"path":file,"beginLine":1,"beginColumn":1,"endLine":1,"endColumn":4}

Notes regarding *findings* that omit *location*:

 * The *consumer* must consider the *finding* to apply to the entirety of all targets.
 * A valid example is a failed check for the existence of a file (note: a location may not refer to an non-existent file)
 * A *process* which guarantees `Associative` repeatability MUST NOT include findings that omit location.

#### Fix

A *fix* is a proposed way to implement a *recommendation*. If a fix is provided, then a recommendation MUST be provided.

```json
{
  "location": Location,
  "newText": String
}
```

* `location` &mdash; **Required** &mdash; Where the recommendation can be applied
* `newText` &mdash; **Optional** &mdash; New text which may be spliced into the *location*

### Extensibility

Each object in this specification may have extra keys introduced by the *process* with proprietary information. The report *consumer* MUST ignore such additional information it does not understand. The `failure` key is reserved and may not be used in extensions.
