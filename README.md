# soal-shift-sisop-modul-1-I06-2021
## Group Member Name:
1. Hilmy Hanif 									(05111942000003)
2. Juan Carlos Tepanus Pardosi  (05111942000017)
3. Khairi Wiryawan              (05111942000023)
### Problem 1
#### 1A 

Collects information from application logs contained in the syslog.log file

answer:

```
sudo less syslog.log
```

explanation :

for the 1A we were asked to get information from the syslog. therefore we can type a command
```sudo less [logname].log```
in order to see the information inside the log file

#### 1B


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

### Problem 2

Steven and Manis founded a startup called “TokoShiSop”, While you and Clemong are the first employees of TokoShiShop. After three years of work, Clemong was appointed to be TokoShiSop’s sales manager, while you became the head of the warehouse who supervised entry and exit of goods.

Every year, TokoShiSop holds a meeting that discusses how sales results and future strategies will be implemented. You’ve been very prepared for this year’s meeting. But suddenly, Steven, Manis, and Clemong ask you to look for some conclusions from the “Laporan-TokoShiSop.tsv” sales data.

#### 2A

Steven wants to appreciate the performance of his employees so far by knowing Row ID and the largest profit percentage (if the largest profit percentage is more than 1, take the largest Row ID). To make your work easier, Clemong provides the definition of profit percentage, i.e.:
```
Profit Percentage = (Profit / Cost Price) * 100
```
Cost Price is obtained from the reduction of Sales with Profit. (Quantity ignored).

Answer:

In this case, we use awk to solve this kind of problem. First, we declare variable that we want to use.
```
LC_NUMERIC=C awk -v profit=0 '
BEGIN { FS="\t"; transid=1; max=0 }
```
From the table of data, we know that sales is in the column 18 and profit in the column 21. Next, implement the profit percentage formula into the program.
```
profit = ($21/($18-$21))*100;
```
Then, check the data and update the profit percentage until we get the largest one.
```
if(profit > max) { max = profit; }

if(profit == max) { transid = $1; }
```
In the end, print out the last transaction with the biggest profit and print out the percentage too.
```
END { print "The last transaction with the largest", transid, "with a percentage of", max,"%\n"}
```

#### 2B

#### 2C

#### 2D
