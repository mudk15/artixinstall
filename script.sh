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
echo -e "\tPrint locale"
until [[ $userlogin =~ ^([a-z]+_)([A-Z]+)$ ]];do
read -rp "  Print username: " userlogin;done
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

#basestrap /mnt/ base base-devel $init elogind-$init $kernel $ucode linux-firmware $texted sudo grub os-prober efibootmgr $dhcpclient
