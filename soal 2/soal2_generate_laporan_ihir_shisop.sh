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

#Answer Number 2C
awk '
BEGIN { FS="\t";
        res=a=b=c=0;
        seg="Corporate"
      }

{ #declare a as Corporate Segment
  if($8 == "Corporate")
  a++;
  #declare b as Consumer Segment
  if($8 == "Consumer")
  b++;
  #declare c as Home Office Segment
  if($8 == "Home Office")
  c++; }

END { 
      #assume Corporate has the least sales
      res=a;

      #update if Consumer has the least sales rather than Corporate
      if(b < res) 
      {
        res=b;
        seg = "Consumer";
      }

      #update if Home Office has the least sales rather than the previous one
      if(c < res)
      {
        res=c;
        seg = "Home Office"
      } 

{ print "The type of customer segment with the least sales is", seg ,"with", res ,"transactions.\n"}
    }
' Laporan-TokoShiSop.tsv >> hasil.txt
