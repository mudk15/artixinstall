#!/bin/bash
echo "print init system (runit and openrc only for now)"
read -p "Your choice: " initsys
echo "print kernel (linux, linux-zen, linux-lts)"
read -p "Your choice: " kernel
echo print hostname
read -p "Your choice: " hostname
echo "print console font (cyr-sun16 for russian)"
read -p "Your choice: " consolfont
echo "print locale (for example ru_RU)"
read -p "Your choice: " local
echo "Are you sure?
yes - contunue
any - exit with no changes"
read -p "Your choice: " answer
case $answer in
yes)
# пошло говно по трубам (yes)
basestrap /mnt base base-devel $initsys elogind-$initsys networkmanager-$initsys $kernel $kernel-headers linux-firmware grub os-prober efibootmgr sudo nano
echo $hostname > /mnt/etc/hostname
echo "127.0.1.1 localhost.localdomain $hostname" > /mnt/etc/hosts
echo FONT=$consolfont > /mnt/etc/vconsole.conf
echo LANG="$local.UTF-8" >> /mnt/etc/locale.conf
echo LC_COLLATE="C" >> /mnt/etc/locale.conf
  # язык
if [ $local != en_US ]
then
echo $local.UTF-8 UTF-8 >> /mnt/etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /mnt/etc/locale.gen
else
echo $local.UTF-8 UTF-8 >> /mnt/etc/locale.gen
fi
artix-chroot /mnt
;;
*)
# любой другой ответ
exit
;;
esac
