#!/bin/bash

#FUNCTIONS
echo_select () {
	if [[ -z $select_var ]];then
		clear
		echo -e "\n\tWrong select\n"
	else
		clear
		echo -e "\n\tYou select $select_var\n"
	fi
	unset select_var
}

until [[ $ready_opt == "yes" ]];do
	PS3=" Print: "
	
	until [[ -n $init ]];do
		echo -e "\n\tSelect init\n"
		select init in runit openrc;do
			break
		done
		
		select_var="$init"
		echo_select
	done
	
	until [[ -n $kernel ]];do
		echo -e "\n\tSelect kernel\n"
		select kernel in linux linux-zen linux-lts linux-hardened;do
			break
		done

		select_var="$kernel"
		echo_select
	done

	until [[ -n $dhcp ]];do
		echo -e "\n\tSelect dhcp\n"
		select dhcp in dhclient dhcpcd;do
			break
		done

		select_var="$dhcp"
		echo_select
	done

	until [[ -n $locale ]];do
		echo -e "\n\tSelect locale\n"
		select locale in $(cat /etc/locale.gen |sed -e '/\.UTF-8/!d;s/#//;s/[[:space:]]UTF-8//;/C\./d');do
			break
		done

		select_var="$locale"
		echo_select
	done

	until [[ -n $timez ]];do
		until [[ -n $region ]];do
			unset region
			echo -e "\n\tSelect region\n"
			select region in $(find /usr/share/zoneinfo/ -type d|sed '1d;/right/d;/posix/d;/America\//d;s/\/usr\/share\/zoneinfo\///');do
				break
			done
			
			select_var="$region"
			echo_select
		done

		unset timez
		echo -e "\n\tSelect region\n"
		select region in $(find /usr/share/zoneinfo/ -type d|sed '1d;/right/d;/posix/d;/America\//d;s/\/usr\/share\/zoneinfo\///');do
			break
		done
		
		select_var="$timez"
		echo_select
	done

	unset userl
	echo -e "\tPrint user login"
	until [[ $userl =~ ^[a-z][a-z0-9-]{0,30}$ ]];do
		read -rp "  Print username: " userl
	done
	
	unset hostn
	echo -e "\n\tPrint hostn"
	until [[ $hostn =~ ^[a-z][a-z0-9-]{0,30}$ ]];do
		read -rp "  Print hostn: " hostn
	done

	echo -e "\n\tAre you sure"
	select ready_opt in yes no;do
		echo -e "\n\tYou select $ready_opt\n"
	break;done

done

echo "Installing linux"
