<?php
require 'src/StructuredAcceptanceTest/StatOutput.php';
require 'src/StructuredAcceptanceTest/StatFinding.php';
require 'src/StructuredAcceptanceTest/StatFindingDetail.php';
require 'src/StructuredAcceptanceTest/StatFindingFix.php';
require 'src/StructuredAcceptanceTest/StatFindingLocation.php';
require 'src/StructuredAcceptanceTest/StatProcess.php';
require 'src/StructuredAcceptanceTest/StatPrinter.php';
require 'src/StructuredAcceptanceTest/StatPrinterJson.php';
require 'src/StructuredAcceptanceTest/StatPrinterPretty.php';

function generateFindings() {
    for ($i=0; $i<3; $i++) {
        sleep(1);
        $finding = new \StructuredAcceptanceTest\StatFinding();
        $finding->failure = true;
        $finding->rule = 'Something is wrong';
        $finding->description = 'You did something wrong';
        $location = new \StructuredAcceptanceTest\StatFindingLocation;
        $location->path = 'aFile.txt';
        $location->beginLine = 5;
        $finding->location = $location;
        yield $finding;
    }
}

// Main program
$process = new \StructuredAcceptanceTest\StatProcess;
$process->name = 'Example test';
$process->version = '0.0.1';
$statOutput = new \StructuredAcceptanceTest\StatOutput;
$statOutput->process = $process;
$statOutput->findings = generateFindings();

#$printer = new \StructuredAcceptanceTest\StatPrinterJson();
$printer = new \StructuredAcceptanceTest\StatPrinterPretty();
$printer->output($statOutput);
