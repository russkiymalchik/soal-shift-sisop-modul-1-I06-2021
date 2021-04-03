# soal-shift-sisop-modul-1-I06-2021
## Group Member Name:
1. Hilmy Hanif 									(05111942000003)
2. Juan Carlos Tepanus Pardosi  (05111942000017)
3. Khairi Wiryawan              (05111942000023)
## Problem 1
Ryujin has just been accepted as an IT support at Bukapedia. He was given the task of making daily reports for the company's internal application, ticky. There are 2 reports that he has to make, namely the report on the list of most error message ratings made by Ticky and user usage reports on the Ticky application. In order to make this report, Ryujin had to do the following:
### 1A 

Collects information from application logs contained in the syslog.log file. The information required includes: log type (ERROR / INFO), log messages, and the username on each log line. Since Ryujin finds it difficult to check one line at a time manually, he uses regex to make his job easier. Help Ryujin create the regex.

answer:

```
grep -i '[error|info].*' syslog.log
```

explanation :

The question asked us to make regex (Regular Expression) that can help Ryujin. Here, we use grep command ```grep [options] pattern [files]``` as we all know that grep stands for  "globally search for regular expression and print out".

For the options, we chose to use ```-i```  in purpose to ignores, case for matching, or in other words to make the regex "case insensitive".

the pattern for the regex is ```[error|info].*``` in purpose to check and print out the line that contain error/info information.

### 1B


Then, Ryujin must display all error messages that appear along with the number of occurrences.

answer:

```
cat syslog.log|grep ERROR|cut -d ":" -f4|cut -d "(" -f1|sort|uniq -c
```

explanation:
First, we need to concatenate the file ```cat filename.format``` that we work on in order to reads data from that certain file and gives their content as output.

After that, we sort the line that contain only error message by ```grep ERROR```. 

Next, we need to categorised the error based on the error message by first cut the line start from ```cut -d ":" -f4``` until ```cut -d "(" -f1```.

for sorting and counting sake, we use command of ```sort|uniq| -c```.

## Problem 2

Steven and Manis founded a startup called “TokoShiSop”, While you and Clemong are the first employees of TokoShiShop. After three years of work, Clemong was appointed to be TokoShiSop’s sales manager, while you became the head of the warehouse who supervised entry and exit of goods.

Every year, TokoShiSop holds a meeting that discusses how sales results and future strategies will be implemented. You’ve been very prepared for this year’s meeting. But suddenly, Steven, Manis, and Clemong ask you to look for some conclusions from the “Laporan-TokoShiSop.tsv” sales data.

### 2A

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
From the table of data, we know that Sales is in the column 18 and Profit in the column 21. Next, implement the profit percentage formula into the program.
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

### 2B

Clemong has a promotional plan in Albuquerque using the MLM method. Therefore, Clemong needs a list of customer names on the 2017 transaction in Albuquerque.

Answer:

In this case, we use awk again to solve this kind of problem. First, write the initial condition to do awk and print the header.
```
awk '
BEGIN { FS="\t";
print "The list of customer names in Albuquerque in 2017 includes:"}
```
From the table of data, we know that Order Date is in the column 3 and City is in the column 10. After that, we create the function to read the year in order date as we shown in below.
```
    date = $3;
    city = $10;

    #declare yy as 2 digits years (in this case we need 17)
    yy = substr(date, 7, 2);
    if (NR != 1)
    { if (yy == 17 && city == "Albuquerque")
       { person[$7]; }
    }
```

```yy = substr(date, 7, 2);``` means we get only two characters from the order date column starting from the seventh sequence from the initial character.

```{ if (yy == 17 && city == "Albuquerque") { person[$7]; }``` means if year is 17 and city is Albuquerque, store the name of this person in the array.

Last, print out all the name of person that we store before in the array.
```
END { for (name in person) 
    { print name; }
    printf "\n"; }
```

### 2C

TokoShiSop focuses on three customer segments, among others: Home Offices, Customers, and Corporates. Clemong wants to increase sales in the customer segment that has the least sales. Therefore, Clemong needs a customer segment and the number of transactions with the least amount of transactions.

Answer:

In this case, we use awk again to solve this kind of problem. As usual, write the initial condition to do awk and declare the variable that we want to use.
```
awk '
BEGIN { FS="\t";
        res=a=b=c=0;
        seg="Corporate"
      }
```
Next, get the data from Segment table which is in column 8. Divide into three condition, "a" for Corporate, "b" for Consumer, and "c" for Home Office.
```
  if($8 == "Corporate")
  a++;
  if($8 == "Consumer")
  b++;
  if($8 == "Home Office")
  c++;
```
Assume that Corporate has the least sales
```
      res=a;
```

Update if Consumer has the least sales rather than Corporate
```
      if(b < res) 
      {
        res=b;
        seg = "Consumer";
      }
```
Update again if Home Office has the least sales rather than the previous one
```
      if(c < res)
      {
        res=c;
        seg = "Home Office"
      } 
```
Last, print out the type of customer segment with the least sales with its total transactions.
```
{ print "The type of customer segment with the least sales is", seg ,"with", res ,"transactions.\n"}
```

### 2D

TokoShiSop divides the sales region into four parts: Central, East, South, and West. Manis wants to find the region that has the least total profit and the total profit of that region.
