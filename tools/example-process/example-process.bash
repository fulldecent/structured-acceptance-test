#!/bin/bash

echo '{'
echo '  "statVersion": "1.0.0",'
echo '  "process": {'
echo '    "name": "One two three example process"'
echo '  },'
echo '  "findings": ['
sleep 1
echo '    {'
echo '      "failure": false,'
echo '      "rule": "Go to your room",'
echo '      "description": "I told you once",'
echo '    },'
sleep 2
echo '    {'
echo '      "failure": false,'
echo '      "rule": "Go to your room",'
echo '      "description": "I told you twice",'
echo '    },'
sleep 3
echo '    {'
echo '      "failure": true,'
echo '      "rule": "Go to your room",'
echo '      "description": "I told you three times",'
echo '    }'
echo '  ]'
echo '}'
