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
