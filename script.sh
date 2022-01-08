#!/bin/bash
PS3="  Print number: "
echo -e "\tSelect init"
select init in runit openrc;do echo -e "\tYou select $init";break;done

echo -e "\tSelect kernel"
select kernel in linux linux-zen linux-lts linux-hardened;do echo -e "\tYou select $kernel";break;done

echo -e "\tSelect ucode"
select ucode in "amd-ucode" "intel-ucode";do echo -e "\tYou select $ucode";break;done

echo -e "\tSelect editor"
select texted in nano vim;do echo -e "\tYou select $texted";break;done

echo -e "\tSelect dhcp client"
select dhcpclient in dhcpcd dhclient;do echo -e "\tYou select $dhcpclient";break;done

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
