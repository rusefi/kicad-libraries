
See https://github.com/rusefi/hw_modular/tree/master/lowside/gerbers for an example of how things are set.


jlc_prepare-*.bat scripts use grep, gawk & sed so Cygwin is required.

# Bill Of Materials

1) See ../BOM_related file for KiCad to produce XXX.csv KiCad BOM.

1) Use prepare_fabricate.bat to invoke jlc_prepare_bom.bat produce XXX-bom.csv final JLC BOM file.

# Placement

1) Use KiCad to produce XXX-top-pos.csv file

1) Use prepare_fabricate.bat to invoke jlc_prepare_position.bat to produce XXX-cpl.csv final JLC placement file.