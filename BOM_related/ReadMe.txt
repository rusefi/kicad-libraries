+++++
This file contains information about how to configure the BOM tool in KICAD to generate a rusEFI BOM
+++++

Kicad BOM creation is kind of a pain as of 4.01. They switched to this xml format thing, and they were kind enough to provide a default xml file, but it  was not linked by default, and it took me some time to find it existed. Also this default BOM is NOT grouped. I then found someone made a grouped version  which was posted here https://kicad-info.s3.amazonaws.com/3929625ac5cd971344cc17cda0c3877a3981d489907.zip I got just the xml file from there, then I modified it slightly which is found here. 
[rueEFI repo https://github.com/rusefi/rusefi]\hardware\rusefi_lib\BOM_related\

I then copied the *.xsl files to my local drive similar to this C:\Program Files\KiCad\bin\scripting\plugins\bom2groupedCsv.xsl Once that was there I then clicked the "add plugin" as shown in the pictures in this folder, and created the 4 options noted on those screens shots. The configuration lines are copied below and pictures are included in this folder. 

not_grouped
C:\Program Files\KiCad\bin\xsltproc.exe -o "%O_BOM_not_grouped.csv" "C:\Program Files\KiCad\bin\scripting\plugins\bom2csv.xsl" "%I"

grouped
C:\Program Files\KiCad\bin\xsltproc.exe -o "%O_BOM_grouped.csv" "C:\Program Files\KiCad\bin\scripting\plugins\bom2groupedCsv.xsl" "%I"

Frankenso BOM (grouped)
C:\Program Files\KiCad\bin\xsltproc.exe -o "%O.csv" "C:\Program Files\KiCad\bin\scripting\plugins\bom2groupedCsv.xsl" "%I"

Frankenso BOM by ref (not grouped)
C:\Program Files\KiCad\bin\xsltproc.exe -o "%O_by-ref.csv" "C:\Program Files\KiCad\bin\scripting\plugins\bom2csv.xsl" "%I"  


+++++
The original notes about how to install and use these BOM generating files were found here 
https://rusefi.com/forum/viewtopic.php?f=13&t=802&start=8
+++++