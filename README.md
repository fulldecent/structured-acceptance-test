[TODO] Made by Will with inspiration from CC

# Structured Acceptance Test

**Note: This specification is a living, versioned document. We welcome your participation and appreciate your patience as we finalize the platform.**

Structured Acceptance Test ("STAT") is a standardized file format for acceptance testing processes. There are two parts:

 * [STAT Input Format](Stat-Input.md) -- describes what the process should test
 * [STAT Output Format](Stat-Output.md) -- describes any opinions rendered by the process

A program that supports Structured Acceptance Test format MUST accept any compliant STAT Input Format and produce compliant STAT Output Format. A compliant command-line program MUST accept any compliant STAT Input Format and produce compliant STAT Output Format on standard output. The compliant command-line program MAY specify that a command line-option be used to enable compliance; in such case, the preferred name `--stat-file=<INPUT>` SHOULD be used.

# Who can use it?

This format is applicable for any process (automated tool or manual) which accepts computer files as input and validates them in some way. Examples of such processes include:

 * Static code analyzers
  * Code linters
  * Code style checkers
  * Minification checkers
 * Other static analyzers
  * Image metadata checkers
  * Image compression checkers
  * Spelling checkers
  * Grammar checkers
  * Digital signature verification
 * Dynamic code analysis
  * Unit tests (logic tests)
  * Automated UI tests
  * Continuous integration tests
 * Volatile testing
  * Link checkers
  * Package manager version checkers (requirement to use latest upstream versions)
  * Deployment testing (dry run)
 * Manual testing
  * Manual inspection
  * Manual walkthroughs
  * Customer feedback

The acceptance testing opinion rendered by the processes above can be used ("consumed") in:

 * Interactive file editors (IDEs, text editors, word processors, image editors)
 * Command-line reporting tools (unit test reports)
 * Source code management / content management systems

# Why should I use it? XKCD 927?

**If your acceptance testing process uses a standardized output format then reporting tools can make better use of it.**

Integrations are amazing. They allow `clang` compilers to show compile errors in your integrated development environment, they allow spelling errors to be underlined in your word processor and they show up as red flags when you review a pull request. But what if *all* of these validations can be shown *everywhere* they are relevant? Standardization supports this.

This is the first widely-applicable standardization of its type so [XKCD 927](https://xkcd.com/927/) does not apply.

Specific benefits include:

 * Validation results are streamable and available to the reporting tool incrementally
 * A simple reporting format applies to source code and non-code validation tasks
 * The formats are extensible for proprietary additions
 * Repeatability is specified

# Project Status

This document is currently version 0.1.0. We follow [Semantic Versioning](http://semver.org/). This will be a candidate for 1.0.0 release when all below items are checked.

 - [x] Gives static analyzers an interoperable, standardized format to produce
 - [x] Standardizes format for consumers: continuous integration, command-line testing, IDEs
 - [x] Supports static code analyzers as well as other non-code analyzers
 - [x] Follows the [Google JSON Style Guide](https://google.github.io/styleguide/jsoncstyleguide.xml)
 - [ ] Supports real-time, incremental reporting
 - [ ] Works with Code [Climate Engine specification](https://github.com/codeclimate/spec)
 - [ ] "Hello world" alpha producer is created
 - [ ] "Hello world" alpha consumer is created
 - [ ] "Hello world" fully-compliant producer is created
 - [ ] "Hello world" fully-compliant consumer is created
 - [ ] "Hello world" fully-featured producer is created
 - [ ] "Hello world" fully-featured consumer is created
 - [ ] Third-part validation of this specification
 - [ ] One major validation tool or report consumer supports this format

# Contributing

Please help to review and improve this specification. Pull requests, issues and discussion are welcome!

Please help to raise awareness by opening an issue with [your favorite static analysis tool](https://en.wikipedia.org/wiki/List_of_tools_for_static_code_analysis) to support this format.

Please open an issue with your favorite integrated development environment or source code sharing tool to request interoperability with this format.
