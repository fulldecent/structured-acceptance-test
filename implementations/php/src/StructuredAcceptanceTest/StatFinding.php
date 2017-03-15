<?php

namespace StructuredAcceptanceTest;

class StatFinding {

    /* Required — true if this finding causes the output to be fail; false otherwise */
    public $failure;

    /* Required — A succinct name which describes the rule which applies to this finding */
    public $rule;

    /* Required — An explanation of the finding */
    public $description;

    /* Optional — See StatFindingDetail */
    public $detail;

    /* Optional — Array of categories */
    // Bug Risk — the meaning is likely to not be what the author intended
    // Clarity — the meaning is unclear
    // Compatibility — the meaning has changed and is no longer valid
    // Complexity — the meaning should be broken into smaller pieces
    // Duplication — unnecessary duplication was found
    // Performance — an inefficient approach was used
    // Security — a situation may allow access to something that should be allowed
    // Style — the style could be improved
    public $categories = [];

    /* Optional — See StatFindingLocation */
    public $location;

    /* Optional — The estimated amount of time it would take a knowledgable human to fix this problem, in seconds */
    public $timeToFix;

    /* Optional — Explanation of an act, using imperative language (eg. "Add a semicolon", "Use the passive voice"), which would fix this finding */
    public $recommendation;

    /* Optional — Array of StatFindingFix */
    public $fixes = [];
}
