#!/bin/bash
for file in *.jpg; do
    ffmpeg -i "$file" -vf "crop=iw:ih-27:0:0" -q:v "cropped_$file"
done
