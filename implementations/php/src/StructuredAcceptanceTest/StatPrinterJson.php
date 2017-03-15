<?php

namespace StructuredAcceptanceTest;

class StatPrinterJson extends StatPrinter {

    function output(StatOutput $statOutput)
    {
        echo "{\n";
        echo "  \"statVersion\": \"$statOutput->statVersion\",\n";
        echo "  \"process\": {\n";
        foreach (array_filter(get_object_vars($statOutput->process)) as $var => $val) {
          $jsonVar = json_encode($var);
          $jsonVal = json_encode($val);
          echo "    $jsonVar: $jsonVal\n";
        }
        echo "  }\n";

//RIGHT NOW THIS ASSUMES WE HAVE A GENERATOR
        $statOutput->findings->rewind();
        if ($statOutput->findings->valid()) {
          echo "  \"findings:\" [\n";
          $isFirstFinding = true;
          foreach ($statOutput->findings as $finding) {
            echo $isFirstFinding ? '    ' : '    ,';
            echo json_encode($finding) . "\n";
            $isFirstFinding = false;
          }
          echo "  ]\n";
        }

// print findings

        echo "}\n";
    }
}
