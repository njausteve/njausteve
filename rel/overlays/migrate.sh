#!/bin/sh
# This depends on the binary being named "server", hence it
# only works in docker deployment mode
# the app name is renamed to server while building and assembling
# the release in the docker file

CURRENT_DIR=$(dirname $0)
$CURRENT_DIR/bin/server eval "Njausteve.Release.migrate()"
