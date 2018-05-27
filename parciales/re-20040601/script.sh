#/bin/bash

sed "s/^.*\].*\].*\][1-9][0-9][0-9][0-9][0-9]*\].*\].*\]SI\].*\].*\]JUBILACION\].*\]NULO$/COBRA/g" TramitesAportantes | sed "s/^.*\].*\].*\][2-9][0-9][0-9]\].*\].*\]SI\].*\].*\]JUBILACION\].*\]NULO$/COBRA/g" | grep -c "COBRA"