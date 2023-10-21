#!/bin/bash

image_id=$(docker image ls | grep timesketch | awk '{print $3}')

if [ "$image_id" = "" ]
  then
    echo "Unable to find docker image for timesketch - please install timesketch first"
    exit 1
fi

echo "Timesketch image id: $image_id"

if [ $# -eq 0 ]
  then
    echo "Please supply path to E01 file"
    exit 1
fi

evidence_path=$(dirname $1)
filename=$(basename $1 .E01)
output_filename="$filename.plaso"

if [ -d ./plaso ]
  then
    echo "./plaso dir already exists"
    i=1
    while [ -f ./plaso/$output_filename ]
      do
        echo "$output_filename already exists"
        output_filename="$filename"_"$i".plaso
	i=$i++
      done
  else
    mkdir plaso
fi

echo "Writing plaso to ./plaso/$output_filename"

docker run -v $evidence_path:/mnt/input -v ./plaso:/mnt/output --entrypoint log2timeline.py $image_id --storage_file /mnt/output/$output_filename --file_filter /usr/share/plaso/filter_windows.yaml /mnt/input/$filename.E01
