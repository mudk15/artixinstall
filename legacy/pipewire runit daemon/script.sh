#!/bin/bash

mkdir /etc/runit/sv/pipewire
mkdir /etc/runit/sv/pipewire-pulse
mkdir /etc/runit/sv/pipewire-media-session

cp pipewire ./run
cp pipewire-pulse ./run-pulse
cp pipewire-media-session ./run-media-session

mv run /etc/runit/sv/pipewire/run
mv run-pulse /etc/runit/sv/pipewire-pulse/run
mv run-media-session /etc/runit/sv/pipewire-media-session/run

read -p " Create links? : " answer
if [ $answer = yes ]
then
ln -s /etc/runit/sv/pipewire /run/runit/service
ln -s /etc/runit/sv/pipewire-pulse /run/runit/service
ln -s /etc/runit/sv/pipewire-media-session /run/runit/service
else
exit
fi


