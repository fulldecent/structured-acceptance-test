<?php

namespace StructuredAcceptanceTest;

class StatOutput {

    /* Required — The version of Structured Acceptance Test against which this output is valid */
    public $statVersion = '1.0.0';

    /* Required — Identification of the process which is doing testing */
    // TYPE: StatProcess
    public $process;

    /* Optional -- A generator or array of StatFindings */
    public $findings;
}
