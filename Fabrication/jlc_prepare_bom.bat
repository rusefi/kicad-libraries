@echo off


set inputFile=%1
set outputFile=%2
set lib_path=%3

IF [%inputFile%] == [] echo inputFile parameter missing
IF [%inputFile%] == [] exit -1

IF [%outputFile%] == [] echo inputFile parameter missing
IF [%outputFile%] == [] exit -1

IF [%lib_path%] == [] echo lib_path parameter missing
IF [%lib_path%] == [] exit -1

if not exist %inputFile% echo Not found %inputFile%
if not exist %inputFile% exit -1

if not exist %lib_path% echo Not found %inputFile%
if not exist %lib_path% exit -1

echo "Translating from %inputFile% to %outputFile%"


echo Comment,Designator,Footprint,LCSC Part #> %outputFile%
                       

if not exist %inputFile% echo Not found %inputFile%
if not exist %inputFile% exit -1

grep C %inputFile% > %outputFile%.temp

sed -f %lib_path%/BOM_related/removedoublecomma.sed %outputFile%.temp | gawk -F "," '{print $3 "," $1 "," $4 "," $6}' >> %outputFile%

rm -f %outputFile%.temp