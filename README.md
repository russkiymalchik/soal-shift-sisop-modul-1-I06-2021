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

#### 2B

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

#### 2C

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

#### 2D

TokoShiSop divides the sales region into four parts: Central, East, South, and West. Manis wants to find the region that has the least total profit and the total profit of that region.
