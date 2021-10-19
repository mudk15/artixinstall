#!/bin/bash

choicexit(){
echo "
       exit without save
    "
exit
}
printgraph(){
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        bios mode               - $syst
        locale                  - $local
        console font            - $consolfont
        timezone                - $tmzn
        user                    - $usrnm
        hostname                - $hostname
        init system             - $initsys
        kernel                  - $kernel"
if [ $syst = EFI ]
then
echo "        (EFI) bootloader name   - $bootid"
else
echo "        (BIOS) disk for grub    - $diskbios"
fi
echo "        network                 - $ntwk
        desktop environment     - $desktop
        display manager         - $display
        additional packages     - $extrpkg

    ╚══════════════════════════════════════════════════════════════╝"
}
printgraph1(){
echo '    ╔══════════════════════════════════════════════════════════════╗'
echo "$choiceanswer"
echo '    ╚══════════════════════════════════════════════════════════════╝
'
}
syst=$(cat /sys/firmware/efi/fw_platform_size)
if [ $syst = 64 ]
then
syst=EFI
else
syst=BIOS
fi
clear
choiceanswer="
       script detected $syst mode
         Do you want change to another?
         yes) - BIOS > EFI or vice versa
         no) - skip
         any) - exit without change
"
printgraph1
read -p "       Your choice: " choic
    case $choic in
    yes)
        if [ $syst = EFI ]
        then
        syst=BIOS
        else
        syst=EFI
        fi
    ;;
    no)
    ;;
    *)
    choicexit
    ;;
    esac
#CHOICE-1
#CHOICE-LOCAL-1
#CHOICE-LOCAL-GRAPHIC
clear
choiceanswer='
       print locale (example ru_RU for Russian)

         or
         s) - skip (default en_US)
         leave empty) - exit without save


'
printgraph
printgraph1
#CHOICE-LOCAL-CODE
read -p "       Your choice: " local
    if [ $local -z ]
    then
    choicexit
    fi
    if [ $local = s ]
    then
    local=en_US
    fi
#CHOICE-CONSOLFONT-1
#CHOICE-CONSOLFONT-GRAPHIC
clear
choiceanswer='
       print console font (cyr-sun16 for russian)

         or
         s) - skip
         leave empty) - exit without save


'
printgraph
printgraph1
#CHOICE-CONSOLFONT-CODE
read -p "       Your choice: " consolfont
    if [ $consolfont -z ]
    then
    choicexit
    fi
    if [ $consolfont = s ]
    then
    consolfont=skipped
    fi
#CHOICE-TMZN-1
#CHOICE-TMZN-GRAPHIC
clear
choiceanswer='
       print timezone (example Europe/Moscow)

         or
         s) - skip (default Europe/London)
         leave empty) - exit without save


'
printgraph
printgraph1
#CHOICE-TMZN-CODE
read -p "       Your choice: " tmzn
    if [ $tmzn -z ]
    then
    choicexit
    fi
    if [ $tmzn = s ]
    then
    tmzn=Europe/London
    fi
#CHOICE-USER-1
#CHOICE-USER-GRAPHIC
clear
choiceanswer='
       print username

         or
         leave empty) - exit without save



'
printgraph
printgraph1
#CHOICE-USER-CODE
read -p "       Your choice: " usrnm
    if [ $usrnm -z ]
    then
    choicexit
    fi
#CHOICE-HOSTNAME-1
#CHOICE-HOSTNAME-GRAPHIC
clear
choiceanswer='
       print hostname

         or
         leave empty) - exit without save



'
printgraph
printgraph1
#CHOICE-HOSTNAME-CODE
read -p "       Your choice: " hostname
    if [ $hostname -z ]
    then
    choicexit
    fi
#CHOICE-INIT-1
#CHOICE-INIT-GRAPHIC
clear
choiceanswer='
        choose init system

         1) - runit
         2) - openrc
         any) - exit without save
         (only runit and openrc for now)

'
printgraph
printgraph1
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
    choicexit
    ;;
    esac
#CHOICE-KERNEL-1
#CHOICE-KERNEL-GRAPHIC
clear
choiceanswer='
       choose kernel

         1) - linux
         2) - linux-zen
         3) - linux-lts
         any) - exit without save

'
printgraph
printgraph1
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
    choicexit
    ;;
    esac
#CHOICE-SYSTEM-1
    case $syst in
    BIOS)
    #CHOICE-SYSTEM-BIOS-1
    #CHOICE-SYSTEM-BIOS-GRAPHIC
    clear
    choiceanswer='
       choice disk for grub

         or
         leave empty) - exit without save



    '
    lsblk
    printgraph
    printgraph1
    #CHOICE-SYSTEM--BIOS-CODE
    read -p "       Your choice: " diskbios
    echo " "
        if [ $diskbios -z ]
        then
        choicexit
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
    choiceanswer='
       print bootloader name

         or
         s) - skip (default grub)
         leave empty) - exit without save


    '
    printgraph
    printgraph1
    #CHOICE-SYSTEM--EFI-CODE
    read -p "       Your choice: " bootid
    echo " "
        if [ $bootid -z ]
        then
        choicexit
        fi
        if [ $bootid = s ]
        then
        bootid=grub
        fi
    ;;
    esac
#CHOICE-NETWORK-1
#CHOICE-NETWORK-GRAPHIC
clear
choiceanswer='
       print network manager

         or
         s) - skip (networkmanager)
         leave empty) - exit with no changes


'
printgraph
printgraph1
#CHOICE-NETWORK-CODE
read -p "       Your choice: " ntwk
    if [ $ntwk -z ]
    then
    choicexit
    fi
    if [ $ntwk = s ]
    then
    ntwk=networkmanager
    fi
#CHOICE-DESKTOP
#CHOICE-DESKTOP-GRAPHIC
clear
choiceanswer='
       print desktop environment

         (gnome, plasma, lxqt, lxde or another)
         s) - skip
         leave empty) - exit with no changes


'
printgraph
printgraph1
#CHOICE-DESKTOP-CODE
read -p "       Your choice: " desktop
    if [ $desktop -z ]
    then
    choicexit
    fi
    if [ $desktop = s ]
    then
    desktop=skipped
    fi
#CHOICE-DISPLAY
#CHOICE-DISPLAY-GRAPHIC
clear
choiceanswer='
       print display manager

         (sddm, lightdm, gdm or another)
         s) - skip
         leave empty) - exit with no changes


'
printgraph
printgraph1
#CHOICE-DISPLAY-CODE
read -p "       Your choice: " display
    if [ $display -z ]
    then
    choicexit
    fi
    if [ $display = s ]
    then
    display=skipped
    fi
#CHOICE-EXTRA
#CHOICE-EXTRA-GRAPHIC
clear
choiceanswer='
       print additional packages

         ( nano, kate, falkon or another)
         s) - skip
         leave empty) - exit with no changes


'
printgraph
printgraph1
#CHOICE-EXTRA-CODE
read -p "       Your choice: " extrpkg
    if [ $extrpkg -z ]
    then
    choicexit
    fi
    if [ $extrpkg = s ]
    then
    extrpkg=skipped
    fi
#CHOICE-RESULT-1
#CHOICE-RESULT-GRAPHIC
clear
choiceanswer='
       Are you sure?

         yes) - contunue
         any) - exit with no changes



'
printgraph
printgraph1
#INSTALL-1
#INSTALL-ANS
read -p "       Your choice: " answer
case $answer in
yes)
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
    #INSTALL-BASESTRAP-DESKTOP
    if [ $desktop != skipped ]
    then
    basestrap /mnt $desktop
    fi
    #INSTALL-BASESTRAP-DISPLAY
    if [ $display != skipped ]
    then
    basestrap /mnt $display $initsys"-"$display
    fi
    #INSTALL-BASESTRAP-EXTRA
    if [ $extrpkg != skipped ]
    then
    basestrap /mnt $extrpkg
    fi
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
        if [ $consolfont != skipped ]
        then
        case $initsys in
            runit)
            echo "FONT=$consolfont" > /mnt/etc/vconsole.conf
            ;;
            openrc)
            artix-chroot /mnt rc-update add consolefont boot
            echo "consolefont=\"$consolfont\"" > /mnt/etc/conf.d/consolefont
            ;;
            esac
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
    choiceanswer="
       print root password
    "
    printgraph1
    artix-chroot /mnt passwd
    #INSTALL-USER-1
    #INSTALL-USER-ADD
    artix-chroot /mnt useradd -m -g users -G wheel -s /bin/bash $usrnm
    echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers
    #INSTALL-USER-PASSWD
    clear
    choiceanswer="
       print $usrnm password
    "
    printgraph1
    artix-chroot /mnt passwd $usrnm
    #INSTALL-AUTOSTART
    #INSTALL-AUTOSTART-NETWORK
    case $initsys in
        runit)
        case $ntwk in
            networkmanager)
            artix-chroot /mnt ln -s /etc/runit/sv/NetworkManager /etc/runit/runsvdir/default
            ;;
            connman)
            artix-chroot /mnt ln -s /etc/runit/sv/connmand/ /etc/runit/runsvdir/default
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
    #INSTALL-AUTOSTART-DISPLAY
    if [ $display != skipped }
    then
        case $initsys in
        runit)
        artix-chroot /mnt ln -s /etc/runit/sv/$display /etc/runit/runsvdir/default
        ;;
        openrc)
        artix-chroot /mnt rc-update add $display
        ;;
        esac
    fi
    #INSTALL-ENDING
    choiceanswer='
       Do you want reboot or...

         1)Enter livecd
         2)Enter artix-chroot
         any) - reboot
    '
    printgraph1
    read -p "       Your choice: " endingchoice
    case $endingchoice in
        1)
        clear
        exit
        ;;
        2)
        clear
        artix-chroot /mnt
        umount -R /mnt
        reboot
        ;;
        *)
        clear
        umount -R /mnt
        reboot
        ;;
    esac
;;
*)
#INSTALL-ANS-ANY
    choicexit
;;
esac
exit
