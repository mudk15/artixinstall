#!/bin/bash
su
echo print init system (runit, openrc only for now)
read initsys
echo print kernel (linux, linux-zen, linux-lts)
read kernel
echo print hostname
read hostname
echo print console font (cyr-sun16 for russian)
read consolfont
# пошло говно по трубам
basestrap /mnt base base-devel $initsys elogind-$initsys networkmanager-$initsys $kernel $kernel-headers linux-firmware grub os-prober efibootmgr sudo nano
echo $hostname > /mnt/etc/hostname
echo 127.0.1.1 localhost.localdomain $hostname > /mnt/etc/hosts
echo $consolfont > /mnt/etc/vconsole.conf