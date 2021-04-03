#!/bin/bash

#1a.
grep -i '[error|info].*' syslog.log

#1b.
cat syslog.log|grep ERROR|cut -d ":" -f4|cut -d "(" -f1|sort|uniq -c

#1c.
cat syslog.log|grep ERROR|cut -d "(" -f2| cut -d ")" -f1|sort|uniq -c
cat syslog.log|grep INFO|cut -d "(" -f2| cut -d ")" -f1|sort|uniq -c
