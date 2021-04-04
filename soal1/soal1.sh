#!/bin/bash

#1a.
cat syslog.log|grep -E -i '[error|info].*'|cut -d ":" -f4

#1b.
cat syslog.log|grep ERROR|cut -d ":" -f4|cut -d "(" -f1|sort|uniq -c

#1c.
cat syslog.log|grep ERROR|cut -d "(" -f2| cut -d ")" -f1|sort|uniq -c
cat syslog.log|grep INFO|cut -d "(" -f2| cut -d ")" -f1|sort|uniq -c
