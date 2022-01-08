#!/bin/bash
PS3="  Print number: "
echo -e "\n\tSelect init\n"
select init in runit openrc;do echo -e "\n\tYou select $init\n";break;done

echo -e "\n\tSelect kernel\n"
select kernel in linux linux-zen linux-lts linux-hardened;do echo -e "\n\tYou select $kernel\n";break;done

echo -e "\n\tSelect ucode\n"
select ucode in "amd-ucode" "intel-ucode";do echo -e "\n\tYou select $ucode\n";break;done

echo -e "\n\tSelect editor\n"
select texted in nano vim;do echo -e "\n\tYou select $texted\n";break;done

echo -e "\n\tSelect dhcp client\n"
select dhcpclient in dhcpcd dhclient;do echo -e "\n\tYou select $dhcpclient\n";break;done

if [[ -z $userlogin ]];then
echo -e "\tUsername is empty"
until [[ $userlogin =~ [a-z]+ ]];do
read -rp "  Print username: " userlogin
done
fi

if [[ -z $hostname ]];then
until [[ $hostname =~ [a-zA-Z0-9\-\.]+ ]];do
read -rp "  Print hostname: " hostname
done
fi

echo -e "
\tInit\t - $init
\tKernel\t - $kernel
\tUcode\t - $ucode
\tEditor\t - $texted
\tDHCP\t - $dhcpclient
\tUser Login\t - $userlogin
\tHostname\t - $hostname
"

#basestrap /mnt/ base base-devel $init elogind-$init $kernel $ucode linux-firmware $texted sudo grub os-prober efibootmgr $dhcpclient
