#!/bin/bash

PS3="  Print number: "
echo -e "\n\tSelect init"
select init in runit openrc;do 
echo -e "\n\tYou select $init\n";break;done

echo -e "\n\tSelect kernel"
select kernel in linux linux-zen linux-lts linux-hardened;do 
echo -e "\n\tYou select $kernel\n";break;done

echo -e "\n\tSelect ucode"
select ucode in "amd-ucode" "intel-ucode";do 
echo -e "\n\tYou select $ucode\n";break;done

echo -e "\n\tSelect editor"
select texted in nano vim;do 
echo -e "\n\tYou select $texted\n";break;done

echo -e "\n\tSelect dhcp client"
select dhcpclient in dhcpcd dhclient;do 
echo -e "\n\tYou select $dhcpclient\n";break;done

echo -e "\n\tSelect network manager"
select netmgr in connman networkmanager;do 
echo -e "\n\tYou select $netmgr\n";break;done

if [[ -z $userlogin ]];then
echo -e "\tPrint user login"
until [[ $userlogin =~ ^([a-z]+)$ ]];do
read -rp "  Print username: " userlogin;done
fi

if [[ -z $hostname ]];then
echo -e "\n\tPrint hostname"
until [[ $hostname =~ ^([a-zA-Z0-9]+)$ ]];do
read -rp "  Print hostname: " hostname;done
fi

if [[ -z $timezone ]];then
echo -e "\n\tPrint timezone"
until [[ $timezone =~ ^([A-Z]{1})([a-z]+/)([A-Z]{1})([a-z]+)$ ]];do
read -rp "  Print timezone: " timezone;done
fi

if [[ -z $locale ]];then
echo -e "\n\tPrint locale"
until [[ $locale =~ ^([a-z]+_)([A-Z]+)$ ]];do
read -rp "  Print username: " locale;done
fi

echo -e "
\tInit\t\t - $init
\tKernel\t\t - $kernel
\tUcode\t\t - $ucode
\tEditor\t\t - $texted
\tDHCP\t\t - $dhcpclient
\tNetwork Manager\t - $netmgr
\tUser Login\t - $userlogin
\tHostname\t - $hostname
\tTimezone\t - $timezone
\tlocale\t\t - $locale
"

basestrap /mnt/ base base-devel $init "elogind-$init" $kernel $ucode linux-firmware $texted sudo grub os-prober efibootmgr $dhcpclient "$netmgr-$init"

fstabgen -U /mnt >> /mnt/etc/fstab

ln -sf /mnt/usr/share/zoneinfo/$timezone /mnt/etc/localtime
artix-chroot /mnt hwclock --systohc

sed -i "/UTF-8/s/^#$locale/$locale/" /mnt/etc/locale.gen
artix-chroot /mnt locale-gen

case $init in
runit)echo -e "$hostname" > /mnt/etc/hostname;;
openrc)echo -e "$hostname" > /mnt/etc/hostname;echo -e "hostname=$hostname" > /mnt/etc/conf.d/hostname;;
esac

echo -e "127.0.1.1 localhost.localdomain $hostname" >> /mnt/etc/hosts

echo -e "LANG=\"$locale.UTF-8\"\nLC_COLLATE=\"C\"" > /mnt/etc/locale.conf

artix-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Artix
artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

artix-chroot /mnt useradd -m -g users -G wheel -s /bin/bash $userlogin

artix-chroot /mnt passwd
artix-chrot /mnt passwd $userlogin

umount -R /mnt
exit

