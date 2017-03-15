<?php

namespace StructuredAcceptanceTest;

class StatFindingLocation {

    /* Required — The file path to which this finding applies */
    public $path;

    /* Optional — The first line of text affected (numbering starts with one), defaults to one */
    public $beginLine;

    /* Optional — The first column of text affected (numbering starts with one), defaults to one */
    public $beginColumn;

    /* Optional — The last column of text affected (numbering starts with one), defaults to the last */
    public $endColumn;

    /* Optional — The last line of text affected (numbering starts with one), defaults to the last */
    public $endLine;
}
