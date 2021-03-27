#!/bin/bash

#Answer Number 2A
LC_NUMERIC=C awk -v profit=0 '
BEGIN { FS="\t"; transid=1; max=0 }

{
 #declare column 18 as sales
 #declare column 21 as profit
 profit = ($21/($18-$21))*100;
 
 if(profit > max) { max = profit; }
 
 if(profit == max) { transid = $1; }
 
}

END { print "The last transaction with the largest", transid, "with a percentage of", max,"%\n"}' Laporan-TokoShiSop.tsv > hasil.txt

#Answer Number 2B
awk '
BEGIN { FS="\t";
print "The list of customer names in Albuquerque in 2017 includes:"}
{
    #declare column 3 as date
    date = $3;

    #declare column 10 as city
    city = $10;

    #declare yy as 2 digits years (in this case we need 17)
    yy = substr(date, 7, 2);
    if (NR != 1)
    { if (yy == 17 && city == "Albuquerque")
       { person[$7]; }
    }
}
END { for (name in person) 
    { print name; }
    printf "\n"; } ' Laporan-TokoShiSop.tsv >> hasil.txt
