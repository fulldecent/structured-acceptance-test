<?php

namespace StructuredAcceptanceTest;

class StatPrinterPretty extends StatPrinter {

    function output(StatOutput $statOutput)
    {
        // Print process
        echo "⭐️ " . $statOutput->process->name;
        if (!empty($statOutput->process->version)) {
            echo ' ' . $statOutput->process->version;
        }
        if (!empty($statOutput->process->website)) {
            echo ', ' . $statOutput->process->website;
        }
        echo PHP_EOL;

// SEE ALL SITUATIONS at https://github.com/fulldecent/structured-acceptance-test/issues/26

        $totalWarnings = 0;
        $totalErrors = 0;

// TODO ADD COLOR
        foreach ($statOutput->findings as $finding) {
            echo $finding->failure ? '🛑 ' : '⚠️ ';
            if (!empty($finding->location) && !empty($finding->location->path)) {
              echo $finding->location->path;
              if (!empty($finding->location->beginLine)) {
                echo ' line ' . $finding->location->beginLine;
                if (!empty($finding->location->beginColumn)) {
                  echo ' col ' . $finding->location->beginColumn;
                }
                if (!empty($finding->location->endLine) && $finding->location->begin != $finding->location->endLine) {
                  echo ' to line ' . $finding->location->endLine;
                  if (!empty($finding->location->endColumn)) {
                    echo ' col ' . $finding->location->endColumn;
                  }
                }
              }
              echo "\n  ";
            }
            echo $finding->description . PHP_EOL;
        }

//TODO ADD SUMMARY        
    }
}
