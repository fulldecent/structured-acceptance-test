<?php

namespace StructuredAcceptanceTest;

class StatProcess {

    /* Required — Identification of the acceptance test process */
    public $name;

    /* Optional — The version of the acceptance test process */
    public $version;

    /* Optional — A brief explanation of the acceptance test process */
    public $description;

    /* Optional — The name of a person responsible for the acceptance test process */
    public $maintainer;

    /* Optional — Contact email address for the maintainer */
    public $email;

    /* Optional — Contact website for the acceptance test process */
    public $website;

    /* Optional — A guarantee of whether the same validation output can be expected in future validation, see notes below */
    // Volatile — Findings MAY change when repeating validation on the identical targets. Example: a web link checker, or package manager version checker. This is the implicit default if not specified.
    // Repeatable — Findings MUST be identical if the program is run again with the same inputs. ("Inputs" is not specified by this standard.)
    // Associative — Findings for targets [a, b] MUST equal the union of findings for [a] and [b] -- in other words, if only one file in changed, only that file need be tested.
    public $repeatability;
}
