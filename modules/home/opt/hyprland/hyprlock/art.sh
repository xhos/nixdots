#!/usr/bin/bash
url=$(playerctl metadata mpris:artUrl)
artist=$(playerctl metadata xesam:artist)
title=$(playerctl metadata xesam:title)
metadata=$(printf "$artist - $title")

if [ $url == "No player found" ]
then
  exit
elif [ -f /home/xhos/.cache/albumart/"$metadata".png ]
then
  echo /home/xhos/.cache/albumart/"$metadata".png
else
  curl -s $url -o /home/xhos/.cache/albumart/"$metadata"
  magick /home/xhos/.cache/albumart/"$metadata" /home/xhos/.cache/albumart/"$metadata".png
  rm /home/xhos/.cache/albumart/"$metadata"
  echo /home/xhos/.cache/albumart/"$metadata".png
fi
