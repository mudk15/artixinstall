#!/bin/bash

#ОГЛАВЛЕНИЕ
#CHOICE-1

    #CHOICE-INIT-1
        #CHOICE-INIT-GRAPHIC
        #CHOICE-INIT-CODE

    #CHOICE-KERNEL-1
        #CHOICE-KERNEL-GRAPHIC
        #CHOICE-KERNEL-CODE

    #CHOICE-HOSTNAME-1
        #CHOICE-HOSTNAME-GRAPHIC
        #CHOICE-HOSTNAME-CODE

    #CHOICE-CONSOLFONT-1
        #CHOICE-CONSOLFONT-GRAPHIC
        #CHOICE-CONSOLFONT-CODE

    #CHOICE-LOCAL-1
        #CHOICE-LOCAL-GRAPHIC
        #CHOICE-LOCAL-CODE

    #CHOICE-TMZN-1
        #CHOICE-TMZN-GRAPHIC
        #CHOICE-TMZN-CODE

    #CHOICE-USER-1
        #CHOICE-USER-GRAPHIC
        #CHOICE-USER-CODE

    #CHOICE-SYSTEM-1
        #CHOICE-SYSTEM-BIOS-1
            #CHOICE-SYSTEM-BIOS-GRAPHIC
            #CHOICE-SYSTEM-BIOS-CODE
        #CHOICE-SYSTEM-EFI-1
            #CHOICE-SYSTEM-EFI-GRAPHIC
            #CHOICE-SYSTEM-EFI-CODE

    #CHOICE-NETWORK-1
        #CHOICE-NETWORK-GRAPHIC
        #CHOICE-NETWORK-CODE

    #CHOICE-EXTRA-1
        #CHOICE-EXTRA-GRAPHIC
        #CHOICE-EXTRA-CODE

    #CHOICE-RESULT-1
        #CHOICE-RESULT-GRAPHIC

#INSTALL
    #INSTALL-ANS
    #INSTALL-ANS-YES

        #INSTALL-BASESTRAP-1
            #INSTALL-BASESTRAP-INIT
            #INSTALL-BASESTRAP-NETWORK
            #INSTALL-BASESTRAP-KERNEL
            #INSTALL-BASESTRAP-GRUB
            #INSTALL-BASESTRAP-EXTRA

        #INSTALL-HOSTNAME
        #INSTALL-HOSTS
        #INSTALL-CONSOLFONT
        #INSTALL-LOCAL
        #INSTALL-LOCALE-GEN
        #INSTALL-FSTAB
        #INSTALL-TMZN
        #INSTALL-GRUB
        #INSTALL-ROOT-PASSWD

        #INSTALL-USER-1
            #INSTALL-USER-ADD
            #INSTALL-USER-PASSWD

        #INSTALL-AUTOSTART-1
        #INSTALL-AUTOSTART-NETWORK
        #INSTALL-ENDING
    #INSTALL-ANS-ANY
syst=$(cat /sys/firmware/efi/fw_platform_size)
if [ $syst = 64 ]
then
syst=EFI
else
syst=BIOS
fi
#CHOICE-1
#CHOICE-INIT-1
#CHOICE-INIT-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       choose init system

         1) - runit
         2) - openrc
         any) - exit without save
         (only runit and openrc for now)

    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-INIT-CODE
read -p "       Your choice: " initsys
    case $initsys in
    1)
    echo " "
    initsys=runit
    echo "you choose $initsys"
    echo " "
    ;;
    2)
    initsys=openrc
    echo "you choose $initsys"
    echo " "
    ;;
    *)
    clear
    exit
    ;;
    esac
#CHOICE-KERNEL-1
#CHOICE-KERNEL-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       choose kernel

         1) - linux
         2) - linux-zen
         3) - linux-lts
         any) - exit without save

    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-KERNEL-CODE
read -p "       Your choice: " kernel
    case $kernel in
    1)
    kernel=linux
    echo "you choose $kernel"
    echo " "
    ;;
    2)
    kernel=linux-zen
    echo "you choose $kernel"
    echo " "
    ;;
    3)
    kernel=linux-lts
    echo "you choose $kernel"
    echo " "
    ;;
    *)
    clear
    exit
    ;;
    esac
#CHOICE-HOSTNAME-1
#CHOICE-HOSTNAME-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print hostname

         or
         q) - exit without save



    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-HOSTNAME-CODE
read -p "       Your choice: " hostname
    if [ $hostname = q ]
    then
    clear
    exit
    fi
#CHOICE-CONSOLFONT-1
#CHOICE-CONSOLFONT-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print console font (cyr-sun16 for russian)

         or
         s) - skip
         q) - exit without save


    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-CONSOLFONT-CODE
read -p "       Your choice: " consolfont
    if [ $consolfont = q ]
    then
    clear
    exit
    fi
    if [ $consolfont = s ]
    then
    consolfont=skip
    fi
#CHOICE-LOCAL-1
#CHOICE-LOCAL-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print locale (for example ru_RU)

         or
         s) - skip (default en_US)
         q) - exit without save


    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-LOCAL-CODE
read -p "       Your choice: " local
    if [ $local = q ]
    then
    clear
    exit
    fi
    if [ $local = s ]
    then
    local=en_US
    fi
#CHOICE-TMZN-1
#CHOICE-TMZN-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print timezone (example Europe/Moscow)

         or
         s) - skip (default Europe/London)
         q) - exit without save


    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-TMZN-CODE
read -p "       Your choice: " tmzn
    if [ $tmzn = q ]
    then
    clear
    exit
    fi
    if [ $tmzn = s ]
    then
    tmzn=Europe/London
    fi
#CHOICE-USER-1
#CHOICE-USER-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print username

         or
         q) - exit without save



    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-USER-CODE
read -p "       Your choice: " usrnm
    if [ $usrnm = q ]
    then
    clear
    exit
    fi
#CHOICE-SYSTEM-1
    case $syst in
    BIOS)
    #CHOICE-SYSTEM-BIOS-1
    #CHOICE-SYSTEM-BIOS-GRAPHIC
    clear
    lsblk
    echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       choice disk for grub

         or
         q) - exit without save



    ╚══════════════════════════════════════════════════════════════╝

    "
    #CHOICE-SYSTEM--BIOS-CODE
    read -p "       Your choice: " diskbios
    echo " "
        if [ $diskbios = q ]
        then
        clear
        exit
        else
        echo "you choose $syst"
        echo "your grub disk is $diskbios"
        echo " "
        fi
    ;;
    EFI)
    #CHOICE-SYSTEM--EFI-1
    #CHOICE-SYSTEM--EFI-GRAPHIC
    clear
    echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print bootloader name

         or
         q) - exit without save



    ╚══════════════════════════════════════════════════════════════╝

    "
    #CHOICE-SYSTEM--EFI-CODE
    read -p "       Your choice: " bootid
    echo " "
        if [ $bootid = q ]
        then
        clear
        exit
        else
        echo "you choose $syst"
        echo "your bootloader name $bootid"
        echo " "
        fi
    ;;
    *)
    clear
    exit
    ;;
    esac
#CHOICE-NETWORK-1
#CHOICE-NETWORK-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print network manager

         or
         s) - skip (networkmanager)
         q) - exit with no changes


    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-NETWORK-CODE
read -p "       Your choice: " ntwk
    if [ $ntwk = q ]
    then
    clear
    exit
    fi
    if [ $ntwk = s ]
    then
    ntwk=networkmanager
    fi
#CHOICE-EXTRA-1
#CHOICE-EXTRA-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       print additional packages

         or
         s) - skip (sudo nano)
         q) - exit with no changes


    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-EXTRA-CODE
read -p "       Your choice: " extrpkg
    if [ $extrpkg = q ]
    then
    clear
    exit
    fi
    if [ $extrpkg = s ]
    then
    extrpkg="sudo nano"
    fi
#CHOICE-RESULT-1
#CHOICE-RESULT-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst
        (EFI) bootloader name   - $bootid
        (BIOS) disk for grub    - $diskbios
        network                 - $ntwk
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝
    ╔══════════════════════════════════════════════════════════════╗

       Are you sure?

         yes) - contunue
         any) - exit with no changes



    ╚══════════════════════════════════════════════════════════════╝

"
#INSTALL-1
#INSTALL-ANS
read -p "       Your choice: " answer
if [ $answer = yes ]
then
#INSTALL-ANS-YES
    #INSTALL-BASESTRAP-1
    #INSTALL-BASESTRAP-INIT
    basestrap /mnt base base-devel $initsys elogind-$initsys
    #INSTALL-BASESTRAP-NETWORK
    basestrap /mnt $ntwk $ntwk"-"$initsys dhcpcd
    #INSTALL-BASESTRAP-KERNEL
    basestrap /mnt $kernel $kernel-headers linux-firmware
    #INSTALL-BASESTRAP-GRUB
    basestrap /mnt grub os-prober efibootmgr
    #INSTALL-BASESTRAP-EXTRA
    basestrap /mnt $extrpkg
    #INSTALL-HOSTNAME
        case $initsys in
        runit)
        echo $hostname > /mnt/etc/hostname
        ;;
        openrc)
        echo $hostname > /mnt/etc/hostname
        echo "hostname=$hostname" > /mnt/etc/conf.d/hostname
        ;;
        esac
    #INSTALL-HOSTS
    echo "127.0.1.1 localhost.localdomain $hostname" >> /mnt/etc/hosts
    #INSTALL-CONSOLFONT
        if [ $consolfont != skip ]
        then
        echo FONT=$consolfont > /mnt/etc/vconsole.conf
        fi
    #INSTALL-LOCAL
    echo LANG="$local.UTF-8" > /mnt/etc/locale.conf
    echo "LC_COLLATE="C"" >> /mnt/etc/locale.conf
    #INSTALL-LOCALE-GEN
        if [ $local != en_US ]
        then
        echo $local.UTF-8 UTF-8 >> /mnt/etc/locale.gen
        echo en_US.UTF-8 UTF-8 >> /mnt/etc/locale.gen
        else
        echo $local.UTF-8 UTF-8 >> /mnt/etc/locale.gen
        fi
        artix-chroot /mnt locale-gen
    #INSTALL-FSTAB
    fstabgen -U /mnt >> /mnt/etc/fstab
    #INSTALL-TMZN
    artix-chroot /mnt ln -sf /usr/share/zoneinfo/$tmzn /etc/localtime
    artix-chroot /mnt hwclock --systohc
    #INSTALL-GRUB
        case $syst in
        BIOS)
        artix-chroot /mnt grub-install --recheck $diskbios
        artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
        ;;
        EFI)
        artix-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=$bootid
        artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
        ;;
        esac
    #INSTALL-ROOT-PASSWD
    clear
    echo "
    ╔══════════════════════════════════════════════════════════════╗

       print root password

    ╚══════════════════════════════════════════════════════════════╝
"
    artix-chroot /mnt passwd
    #INSTALL-USER-1
    #INSTALL-USER-ADD
    artix-chroot /mnt useradd -m -g users -G wheel -s /bin/bash $usrnm
    echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers
    #INSTALL-USER-PASSWD
    clear
    echo "
    ╔══════════════════════════════════════════════════════════════╗

       print $usrnm password

    ╚══════════════════════════════════════════════════════════════╝
"
    echo print pass for $usrnm
    artix-chroot /mnt passwd $usrnm
    #INSTALL-AUTOSTART-1
    #INSTALL-AUTOSTART-NETWORK
    case $initsys in
        runit)
        case $ntwk in
            networkmanager)
            artix-chroot /mnt ln -s /etc/runit/sv/NetworkManager /etc/runit/runsvdir/default
            ;;
            connman)
            artix-chroot /mnt ln -s etc/runit/sv/connmand/ /etc/runit/runsvdir/default
            ;;
        esac
        ;;
        openrc)
        case $ntwk in
            networkmanager)
            artix-chroot /mnt rc-update add NetworkManager
            ;;
            connman)
            artix-chroot /mnt rc-update add connmand
            ;;
        esac
        ;;
    esac
    #INSTALL-ENDING
    umount -R /mnt
    reboot
else
#INSTALL-ANS-ANY
    clear
    exit
fi
exit
