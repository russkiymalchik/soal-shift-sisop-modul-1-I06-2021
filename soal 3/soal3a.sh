#!bin/bash

for((i=1; i<=23; i++))
do
        wget -O Koleksi_$i https://loremflickr.com/320/240/kitten -a Foto.log
done

fdupes /#file directory
