# jUnit to STAT converter

This tool allows you convert [jUnit format](http://help.catchsoftware.com/display/ET/JUnit+Format) to STAT.

## Usage
ruby junit-stat-converter \<file>

STAT generates by next rules:
* Process name is always 'JUnit'
* Each testcase has corresponding finding
    * If test failed finding marks as failed
    * The rule of finding is the name of testcase
    * Description is failure message