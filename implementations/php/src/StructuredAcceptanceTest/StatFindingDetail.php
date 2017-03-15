<?php

namespace StructuredAcceptanceTest;

class StatFindingDetail {

    /* Required — A markdown-formatted, detailed explanation the finding, which may include links to further information */
    public $body = '1.0.0';

    /* Optional — An array of StatFindLocations which provide context to the finding, with the first being the most closely related */
    public $trace = [];
}
