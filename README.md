# Static Analysis Structured Report

SASR is an open data format for static analysis tools.

This document is version 0.0.1a. This project will follow [Semantic Versioning](http://semver.org/). Also, this recommendation follows the [Google JSON Style Guide](https://google.github.io/styleguide/jsoncstyleguide.xml)

Tools which support SASR will directly output a SASR-formatted report or include an option which allows it to directly output this report.

# What is Static Analysis?

Static analysis is the review of a document that is performed without implementing that document's content. For example, to analyze United States constitution, the following analysis would be in scope:

 * Check spelling
 * Check grammar
 * Check formatting
 * Verify signatures
 * Verify compliance with any published state acceptance criteria for constitutions

The following, although important, would be out of scope:

 * Poll state governments to see if they would ratify the constitution
 * Create a government using this constitution to see if unexpected outcomes arise
 * Deliver the constitution to the state governments to confirm roads are traversable

This exact form of analysis is very often used in computer programming (static program analysis), where the syntax of a program's source code is checked in similar ways. The example above is used to demonstrate that static analysis also applies to other forms of documents.

# The Problem and Solution

[Many tools exist](https://en.wikipedia.org/wiki/List_of_tools_for_static_code_analysis) for static analysis. At a mimumum, each tool is capable of approving or rejecting the document for a specific criteria (for example, "spell is  good"). Commonly, these tools are able to produce a list of errors and they specify exactly which part of the document is affected.

Unfortunately, the most popular tools for static analysis do not have a common reporting format. And this reduces interoperability. This proposal recomends an open and interoperable reporting format for static analysis tools.

# The SASR Format

SASR is a structured format which allows static analysis tools to record specific instances of found errors. SASR is transmitted is JSON format and contains two parts, the header part and the findings part including an arbitrary number of findings:

```javascript
{
    "generator" : "...",
    "generationTime" : 4.23,
    // ...
    "findings" : [
    {
        "file" : "path/filename.ext",
        "line" : 47,
        // ...
    },
    // ...
    ]
}
```

## Header

The header part is a collection of key-value pairs as shown:

| Name              | Type       | Optional | Description                                                                       |
|-------------------|------------|----------|-----------------------------------------------------------------------------------|
| `generator`       | string     | yes      | The name and version number of the program or process which generated this report |
| `generationTime`  | number (positive float)     | yes      | The number of seconds spent to generate this report                               |
| `accepted`        | true/false | no       | True if no critical findings ("errors") have been found; false otherwise |

## Findings

Each finding is represented as a list of key-value pairs as shown below:

| Name              | Type           | Optional | Description                                                                                                                                                     |
|-------------------|----------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `generator`       | string         | yes      | The name and version number of the program or process which generated this finding, if different than the `generator` in the header part |
| `file`            | string         | yes      | The filename (with path) to which this finding applies                                                                                                          |
| `line`            | number (positive integer) | yes      | The line number of the file to which this finding applies (numbering starts at 1)                                                                                                       |
| `column`          | number (positive integer) | yes      | The column number of the line to which this finding applies (numbering starts at 1)                                                                                                       |
| `type`            | string         | no       | A succinct categorization for the kind of finding which is being reported (a taxonomy of `types` is not yet established in this specification)                  |
| `message`         | string         | no       | A complete explanation of the finding                                                                                                                           |
| `critical`        | true/false     | no       | True if this is a critical finding ("error") which would cause this analysis to reject the document; false if this is a supplementary finding ("warning")       |
| `severity`        | number         | yes      | A number which prioritizes the level of the finding, zero refers to the most important, and higher numbers are less important, negative numbers are not allowed |
| `recommendations` | array of recommendation | yes      | A collection of potential replacements which would fix this finding (but not necessarily fix other findings)                                                    |

## Recommendations

Following is the representation format for recommendations:

| Name               | Type                      | Optional | Description                                                                                                                                                      |
|--------------------|---------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `startLine`        | number (positive integer) | no       | The first line of text to be replaced with (numbering starts at 1)
| `startColumn`      | number (positive integer) | yes      | The first column of the start line to be replaced with (numbering starts at 1), the first column is used if this is omitted                 |
| `endLine`          | number (positive integer) | no       | The last line of text to be replaced with (numbering starts at 1)                                                                             |
| `endColumn`        | number (positive integer) | yes      | The last column of the end line to be replaced with (numbering starts at 1), the last column is used if this is omitted                     |
| `replacement`      | string                    | no       | New text which should be sliced into the file                                                                                                                    |
| `correction`       | string                    | no       | An explanation, using imperative language (eg. "Add a semicolon", "Use the passive voice") which describes the act completed by splicing in the replacement text |


# Status

Please help to review and improve this document. Pull requests, issues and discussion are welcome!

Please help to raise awareness by opening an issue with your favorite static analysis tool to support this format.

Please open an issue with your favorite integrated development environment or source code sharing tool to request interoperability with this format.


