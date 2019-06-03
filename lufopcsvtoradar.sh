#!/bin/bash
###########################
#Created by benjamin cathelineau
#free to use and modify to your pleasure
#settings
nameoffavorite="radars"
IFS=$'\n'
csvdirectory="csvd"
filetocreate="radars.gpx"
#
###########################
cd $csvdirectory
for f in *; do (cat $f; echo '') >> csvfileconcatened; done
echo "Shell script to generate favourite gpx from lufop csv to osmand"
touch $filetocreate
echo """<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<gpx version=\"1.1\" creator=\"OsmAnd~ 3.3.8\" xmlns=\"http://www.topografix.com/GPX/1/1\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd\">
  <metadata>
    <name>\"$nameoffavorite\"</name>
  </metadata>""" >> $filetocreate
j=0;
for i in $(cat ./csvfileconcatened)
do 
let j++
longitude=$(echo $i | cut -d, -f1 | tr -d " " )
latitude=$(echo $i | cut -d, -f2 | tr -d " " )
nom=$(echo $i | cut -d, -f3 | tr -d " " | tr -d "\"")
echo """<wpt lat=\"$latitude\" lon=\"$longitude\">
    <name>\"$nom-$j\"</name>
    <type>$nameoffavorite</type>
    <extensions>
      <color>#ff0000</color>
    </extensions>
  </wpt>""" >> $filetocreate
  echo $j
done