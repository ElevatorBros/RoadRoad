#!/bin/sh
echo -ne '\033c\033]0;RoadRoad\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/RoadRoad.x86_64" "$@"
