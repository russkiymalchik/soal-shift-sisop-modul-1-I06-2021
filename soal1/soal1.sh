#!/bin/bash

#a
sudo less syslog.log

#b
grep -w "ERROR" syslog.log
error=$(grep -c "ERROR" syslog.log)

echo "${error}"
