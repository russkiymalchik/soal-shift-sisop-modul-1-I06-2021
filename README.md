# soal-shift-sisop-modul-1-I06-2021
## Group Member Name:
1. Khairi Wiryawan                      (05111942000023)
2. Juan Carlos Tepanus Pardosi          (05111942000017)
3. Hilmy Hanif Ibrahim					(05111942000005)

## Problem 1
Ryujin has just been accepted as an IT support at Bukapedia. He was given the task of making daily reports for the company's internal application, ticky. There are 2 reports that he has to make, namely the report on the list of most error message ratings made by Ticky and user usage reports on the Ticky application. In order to make this report, Ryujin had to do the following:
### 1A 

Collects information from application logs contained in the syslog.log file. The information required includes: log type (ERROR / INFO), log messages, and the username on each log line. Since Ryujin finds it difficult to check one line at a time manually, he uses regex to make his job easier. Help Ryujin create the regex.

answer:

```
cat syslog.log|grep -E -i '[error|info].*'|cut -d ":" -f4
```

explanation :

The question asked us to make regex (Regular Expression) that can help Ryujin. Here, we use grep command ```grep [options] pattern [files]``` as we all know that grep stands for  "globally search for regular expression and print out".

For the options, we chose to use ```-i```  in purpose to ignores, case for matching, or in other words to make the regex "case insensitive" and we ise ```-E``` in order to treat pattern as an extended regular expression.

the pattern for the regex is ```[error|info].*``` in purpose to check and print out the line that contain error/info information. after that, we cut the line ```cut -d ":" -f4``` only start from Error/Info, messages, and users

### 1B


Then, Ryujin must display all error messages that appear along with the number of occurrences.

answer:

```
cat syslog.log|grep ERROR|cut -d ":" -f4|cut -d "(" -f1|sort|uniq -c
```

explanation:
we sort the line that contain only error message by ```grep ERROR```. 

Next, we need to categorised the error based on the error message by first cut the line start from ```cut -d ":" -f4``` until ```cut -d "(" -f1```.

for sorting and counting sake, we use command of ```sort|uniq| -c```.

### 1C
Ryujin must also be able to display the number of occurrences of the ERROR and INFO logs for each user

answer :
```
cat syslog.log|grep ERROR|cut -d "(" -f2| cut -d ")" -f1|sort|uniq -c
cat syslog.log|grep INFO|cut -d "(" -f2| cut -d ")" -f1|sort|uniq -c
```
explanation :

1C question is quite similar with 1B. The differences is that we need to count and cattegorise amount of error/info from certain user and then list them.

so the difference here in the cut proccess. we need to cut error/info only by the username of each line. that is why we only pick between "(" and ")" ```cut -d "(" -f2| cut -d ")" -f1```.

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

Error when solving problem:

We got an error when we run program 2A. The error is because we were wrong when declaring the variable ```profit=0```. It should be before the BEGIN statement, but we input it into BEGIN statement.

![alt text](https://github.com/russkiymalchik/soal-shift-sisop-modul-1-I06-2021/blob/main/screenshots/error%202A.png)

Below is the result of Problem 2A:

![alt text](https://github.com/russkiymalchik/soal-shift-sisop-modul-1-I06-2021/blob/main/screenshots/Result%202A.png)

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

Error when solving problem:

When we run program 2B, we got some error. The first error is because we were wrong when declaring the variable ```date = $3; city = $10;```. It should be outside the BEGIN statement, but we input it in BEGIN statement.

![alt text](https://github.com/russkiymalchik/soal-shift-sisop-modul-1-I06-2021/blob/main/screenshots/error%202B_code1.png)

The second error is the result do not want print the statement "The list of customer names in Albuquerque in 2017 includes:" before persons name.

![alt text](https://github.com/russkiymalchik/soal-shift-sisop-modul-1-I06-2021/blob/main/screenshots/error%202B_result.png)

This error is because we use ```echo``` when we want to print out in the END statement. So, as the solution we use ```print``` instead of using ```echo``` . After that, we move that into BEGIN statement instead of print out in END statement.

![alt text](https://github.com/russkiymalchik/soal-shift-sisop-modul-1-I06-2021/blob/main/screenshots/error%202B_code.png)

Below is the result of Problem 2B:

![alt text](https://github.com/russkiymalchik/soal-shift-sisop-modul-1-I06-2021/blob/main/screenshots/Result%202B.png)

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

Error when solving problem:

Below is the result of Problem 2C:

![alt text](https://github.com/russkiymalchik/soal-shift-sisop-modul-1-I06-2021/blob/main/screenshots/Result%202C.png)


### 2D

TokoShiSop divides the sales region into four parts: Central, East, South, and West. Manis wants to find the region that has the least total profit and the total profit of that region.


## Problem 3
Kuuhaku is a person who really likes to collect digital photos, but Kuuhaku is also a lazy person so he doesn't want to bother looking for photos, besides that he is also shy, so he doesn't want anyone to see his collection, unfortunately, he has a friend named Steven who made being nosy his primary responsibility. Kuuhaku then had an idea, a way so that Steven won't be able to see his collection. To make his life easier, he is asking for your help. The idea is:
### 3A
Make a script to download 23 images from "https://loremflickr.com/320/240/kitten" and save the logs to the file "Foto.log". Since the downloaded images are random, it is possible that the same image is downloaded more than once, therefore you have to delete the same image (no need to download new images to replace them). Then save the images with the name "Kumpulan_XX" with consecutive numbers without missing any number (example: Koleksi_01, Koleksi_02, ...).

answer (with the help of fdupes, a program that allows to identify duplicate files in the system):
```
#!bin/bash

for((i=1; i<=23; i++))
do
        wget -O Koleksi_$i https://loremflickr.com/320/240/kitten -a Foto.log
done

fdupes -d /home/hilmyhnf/Koleksi
```

### 3B
Because Kuuhaku is too lazy to run the script manually, he also asks you to run the script once a day at 8 o'clock in the evening for some specific dates every month, namely starting the 1st every seven days (1,8, ...), as well as from the 2nd once every four days (2,6, ...). To tidy it up, the downloaded images and logs are moved to a folder named the download date with the format "DD-MM-YYYY" (example: "13-03-2023").

answer:
- bash script to move "Koleksi_XX" files and Foto.log to destination directory 
```
#!bit/bash

# rerun soal3a.sh script
bash soal3a.sh

# set the destination directory
destination="$(date +%d-%m-%Y)"

# make the directory destination
mkdir /home/hilmyhnf/$destination

# move all Koleksi files to directory destination
mv Koleksi_* /home/hilmyhnf/$destination

# move Foto.log to directory destination
mv Foto.log /home/hilmyhnf/$destination

```
- crontab to run soal3.bsh
```
0 20 1-31/7,2-31/4 * * /bin/bash /home/hilmyhnf/Koleksi/soal3b.sh
```
