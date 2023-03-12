#####################################################################################
#                                 generate_diffs.sh                                 #
#                                    08/13/2020                                     #
#                             Written By David Holdeman                             #
#   Checks for changed .kicad_pcb files, generates visual diffs, and uploads them   #
#                                      to FTP.                                      #
#####################################################################################
# The FTP location this uploads to is /diffs/plot_<name of kicad_pcb file, without the extension>
# In that directory are subdirectorys containing generated SVGs, as well as a 'web' subdirectory,
# which contains index.html. Open that in a web browser and you get a nice visual diff of each layer.
#!/bin/bash

export PATH="$PATH:$(readlink -f ../KiCad-Diff/bin/)"

function gendiffs() {
  if [ -f "$(dirname "$1")/version.txt" ] && [ $(git rev-list -1 $(git rev-parse HEAD) "$(dirname "$1")/version.txt") = $(git rev-parse HEAD) ]; then
    OLDHASH=$(git rev-list -2 $(git rev-parse HEAD) "$1" | tail -n1 | head -c7)
    kidiff -w -s Git -b $OLDHASH -a $(git rev-parse --short HEAD) -d :0 "$1"
  fi
  kidiff -w -s Git -b $(git rev-parse --short HEAD~1) -a $(git rev-parse --short HEAD) -d :0 "$1"
  if [ -s "$(dirname "$1")/.kidiff/diff.txt" ]; then
   mkdir "../kidiff/$(dirname "$1")"
   mv "$(dirname "$1")"/.kidiff/* "../kidiff/$(dirname "$1")"
  else
   rm -rf "$(dirname "$1")/.kidiff"
  fi
}
export -f gendiffs

mkdir ../kidiff
find . -name "*.kicad_pcb" -not -path "./rusefi_lib/*" -exec bash -c 'gendiffs "$0"' {} \;
if [ "$RUSEFI_SSH_PASS" != "" ] && [ "$RUSEFI_SSH_USER" != "" ] && [ "$RUSEFI_SSH_SERVER" != "" ]; then
  tar -czf - -C ../kidiff . | sshpass -p "$RUSEFI_SSH_PASS" ssh -o StrictHostKeyChecking=no "$RUSEFI_SSH_USER"@"$RUSEFI_SSH_SERVER" "tar -xzf - -C docs/diffs/"
fi
