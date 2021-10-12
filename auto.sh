#!/bin/bash
stad=1
case $stad in
1)
echo "print init system (runit and openrc only for now)"
read -p "Enter: " initsys
echo "print kernel (linux, linux-zen, linux-lts)"
read -p "Enter: " kernel
echo print hostname
read -p "Enter: " hostname
echo "print console font (cyr-sun16 for russian)"
read -p "Enter: " consolfont
echo "print locale (for example ru_RU)"
read -p "Enter: " local
stad=2
;;
2)
echo "Are you sure?
no - return to start
yes - contunue
exit - exit with no changes"
read answer
case $answer in
no)
stad=1
;;
"exit")
exit
;;
*)
stad=2
;;
esac
;;
esac
