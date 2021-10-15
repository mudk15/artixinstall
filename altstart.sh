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
        #CHOICE-SYSTEM-GRAPHIC
        #CHOICE-SYSTEM-CODE-1

            #CHOICE-SYSTEM-BIOS-1
                #CHOICE-SYSTEM-BIOS-GRAPHIC
                #CHOICE-SYSTEM-BIOS-CODE

            #CHOICE-SYSTEM-EFI-1
                #CHOICE-SYSTEM-EFI-GRAPHIC
                #CHOICE-SYSTEM-EFI-CODE

    #CHOICE-NETWORK-1
        #CHOICE-NETWORK-GRAPHIC
        #CHOICE-NETWORK-CODE

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

#CHOICE-1
#CHOICE-INIT-1
#CHOICE-INIT-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝



    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  choose init system                                          ║
    ║                                                              ║
    ║    1) - runit                                                ║
    ║    2) - openrc                                               ║
    ║    any) - exit without save                                  ║
    ║    (only runit and openrc for now)                           ║
    ║                                                              ║
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
    exit
    ;;
    esac
#CHOICE-KERNEL-1
#CHOICE-KERNEL-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  choose kernel                                               ║
    ║    1) - linux                                                ║
    ║    2) - linux-zen                                            ║
    ║    3) - linux-lts                                            ║
    ║    any) - exit without save                                  ║
    ║                                                              ║
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
    exit
    ;;
    esac
#CHOICE-HOSTNAME-1
#CHOICE-HOSTNAME-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  print hostname                                              ║
    ║    or q) - exit without save                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-HOSTNAME-CODE
read -p "       Your choice: " hostname
    if [ $hostname = q ]
    then
    exit
    fi
#CHOICE-CONSOLFONT-1
#CHOICE-CONSOLFONT-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  print console font (cyr-sun16 for russian)                  ║
    ║    or                                                        ║
    ║    s) - skip                                                 ║
    ║    q) - exit without save                                    ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-CONSOLFONT-CODE
read -p "       Your choice: " consolfont
    if [ $consolfont = q ]
    then
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
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  print locale (for example ru_RU)                            ║
    ║    s) - skip (default en_US)                                 ║
    ║    q) - exit without save                                    ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-LOCAL-CODE
read -p "       Your choice: " local
    if [ $local = q ]
    then
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
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  print timezone (example Europe/Moscow)                      ║
    ║    s) - skip (default Europe/London)                         ║
    ║    q) - exit without save                                    ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-TMZN-CODE
read -p "       Your choice: " tmzn
    if [ $tmzn = q ]
    then
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
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  print username                                              ║
    ║    or q) - exit without save                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-USER-CODE
read -p "       Your choice: " usrnm
    if [ $usrnm = q ]
    then
    exit
    fi
#CHOICE-SYSTEM-1
#CHOICE-SYSTEM-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your system is                                              ║
    ║    1) - BIOS                                                 ║
    ║    2) - EFI                                                  ║
    ║    any) - exit without save                                  ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-SYSTEM-CODE-1
read -p "       Your choice: " syst
echo " "
    case $syst in
    1)
    #CHOICE-SYSTEM-CODE-BIOS-1
    #CHOICE-SYSTEM-CODE-BIOS-GRAPHIC
    clear
    syst=BIOS
    lsblk
    echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  choice disk for grub                                        ║
    ║    or exit) - exit without save                              ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

    "
    #CHOICE-SYSTEM-CODE-BIOS-CODE
    read -p "       Your choice: " diskbios
    echo " "
        if [ $diskbios = exit ]
        then
        exit
        else
        echo "you choose $syst"
        echo "your grub disk is $diskbios"
        echo " "
        fi
    ;;
    2)
    #CHOICE-SYSTEM-CODE-EFI-1
    #CHOICE-SYSTEM-CODE-EFI-GRAPHIC
    clear
    syst=EFI
    echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

        init system             - $initsys
        kernel                  - $kernel
        hostname                - $hostname
        console font            - $consolfont
        locale                  - $local
        timezone                - $tmzn
        user                    - $usrnm
        system                  - $syst

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  print bootloader name                                       ║
    ║    or exit) - exit without save                              ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

    "
    #CHOICE-SYSTEM-CODE-EFI-CODE
    read -p "       Your choice: " bootid
    echo " "
        if [ $bootid = exit ]
        then
        exit
        else
        echo "you choose $syst"
        echo "your bootloader name $bootid"
        echo " "
        fi
    ;;
    *)
    exit
    ;;
    esac
#CHOICE-NETWORK-1
#CHOICE-NETWORK-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

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

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  print network manager                                       ║
    ║    s) - skip (networkmanager)                                ║
    ║    q) - exit with no changes                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

"
#CHOICE-NETWORK-CODE
read -p "       Your choice: " ntwk
    if [ $ntwk = q ]
    then
    exit
    fi
    if [ $ntwk = s ]
    then
    ntwk=networkmanager
    fi
#CHOICE-RESULT-1
#CHOICE-RESULT-GRAPHIC
clear
echo "
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  your choice                                                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝

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

    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║  Are you sure?                                               ║
    ║    yes) - contunue                                           ║
    ║    any) - exit with no changes                               ║
    ║                                                              ║
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
    basestrap /mnt $ntwk"-"$initsys
    #INSTALL-BASESTRAP-KERNEL
    basestrap /mnt $kernel $kernel-headers linux-firmware
    #INSTALL-BASESTRAP-GRUB
    basestrap /mnt grub os-prober efibootmgr sudo nano
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
    echo print root password
    artix-chroot /mnt passwd
    #INSTALL-USER-1
    #INSTALL-USER-ADD
    artix-chroot /mnt useradd -m -g users -G wheel -s /bin/bash $usrnm
    echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers
    #INSTALL-USER-PASSWD
    echo print pass for $usrnm
    artix-chroot /mnt passwd $usrnm
    #INSTALL-AUTOSTART-1
    #INSTALL-AUTOSTART-NETWORK
    case $initsys in
        runit)
        artix-chroot /mnt ln -s /etc/runit/sv/NetworkManager/ /etc/runit/runsvdir/default
        ;;
        openrc)
        artix-chroot /mnt rc-update add NetworkManager
        ;;
    esac
    #INSTALL-ENDING
    umount -R /mnt
    reboot
else
#INSTALL-ANS-ANY
    exit
fi
exit
