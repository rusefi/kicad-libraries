rem
rem This script takes care only of the mechanical part of the transformation - there is still manual rotation at least for some diodes!
rem 

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

echo "Position file: Translating grom %inputFile% to %outputFile%"

echo Designator,Mid X,Mid Y,Layer,Rotation> %outputFile%

grep -v Package %inputFile% | gawk -F "," '{ sub(/\..*/,"", $6); print $1 "," $4 "mm," $5 "mm,Top," $6}' > %outputFile%.temp
sed -f %lib_path%/BOM_related/unquote.sed %outputFile%.temp >> %outputFile%

rm -f %outputFile%.temp