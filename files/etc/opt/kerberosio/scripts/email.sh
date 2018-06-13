#!/bin/bash

# --------------------------------------
# The first parameter is the JSON object
#
# e.g. {"regionCoordinates":[308,250,346,329],"numberOfChanges":194,"timestamp":"1486049622","microseconds":"6-161868","token":344,"pathToImage":"1486049622_6-161868_frontdoor_308-250-346-329_194_344.jpg","instanceName":"frontdoor"}

echo "$1" >> /tmp/json.txt

/usr/bin/python3 `dirname ${BASH_SOURCE[0]}`/mail.py "$1"
