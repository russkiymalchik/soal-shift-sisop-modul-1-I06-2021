# soal-shift-sisop-modul-1-I06-2021

## 1
#### A 

Collects information from application logs contained in the syslog.log file

answer:

```
sudo less syslog.log
```

explanation :

for the 1A we were asked to get information from the syslog. therefore we can type a command
```sudo less [logname].log```
in order to see the information inside the log file

### B


Display all error messages that appear along with the number of occurrences

answer:

```
grep -w "ERROR" syslog.log
error=$(grep -c "ERROR" syslog.log)

echo "${error}"
```

explanation:
We were requested to display message that only have "ERROR" in it. here come the ```grep```. Here, ```grep -w "ERROR" syslog.log```, the grep command to select only those lines that contain matches to form whole words.

Next, we need to count how much line that contain "ERROR". ```grep -c "ERROR" syslog.log```came to count lines for matched words. We save the value into the variable ```error``` that later we print out ```echo "${error}"```
