#!/bin/bash
################################
################################        CHECK SYSTEM
################################
system=$(cat /sys/firmware/efi/fw_platform_size)
if [ "$system" = 64 ]
then
system=EFI
else
system=BIOS
fi
################################
################################        CHOICEXIT
################################
choicexit(){
echo "
       exit without save
"
exit
}
################################
################################        PRINTGRAPH
################################
printgraph(){
echo "
    ╔══════════════════════════════════════════════════════════════╗

       your choice


        bios mode               - $system
        locale                  - $locale
        console font            - $consolefont
        timezone                - $timezone
        user                    - $username
        hostname                - $hostname
        init system             - $initsystem
        kernel                  - $kernel"
if [ "$system" = EFI ]
then
echo "        (EFI) bootloader name   - $efiboot"
else
echo "        (BIOS) disk for grub    - $biosdisk"
fi
echo "        network                 - $network
        desktop environment     - $desktop
        display manager         - $display
        additional packages     - $extrapackages

    ╚══════════════════════════════════════════════════════════════╝"
}
################################
################################        PRINTANSWER
################################
printanswer(){
echo '    ╔══════════════════════════════════════════════════════════════╗'
echo "$answer"
echo '    ╚══════════════════════════════════════════════════════════════╝
'
}


################################
################################        FUNCTIONS
################################
################################
################################        SYSTEM FUNC
################################
answersystem(){
clear
answer="
        script detected $system mode

            Do you want change to another?
            s) - skip
            yes) - EFI > BIOS or vice versa
            any) - exit without change

"
printgraph
printanswer
read -p "       Your choice: " systemans
    case $systemans in
    yes)
        if [ "$system" = EFI ]
        then
        system=BIOS
        else
        system=EFI
        fi
    ;;
    s)
    ;;
    *)
    choicexit
    ;;
    esac
}
################################
################################        LOCALE FUNC
################################
answerlocale(){
clear
answer="
        print locale (example ru_RU for Russian)

            or print
            s) - skip
            d) - default (en_US)
            empty) - exit without save

"
printgraph
printanswer
read -p "       Your choice: " localeans
    if [ -z "$localeans" ]
    then
    choicexit
    fi
    case $localeans in
    s)
    ;;
    d)
    locale=en_US
    ;;
    *)
    locale=$localeans
    ;;
    esac
}
################################
################################        FONT FUNC
################################
answerfont(){
clear
answer='
        print console font (cyr-sun16 for russian)

            or
            s) - skip
            sk) if you already print, but want delete
            empty) - exit without save

'
printgraph
printanswer
read -p "       Your choice: " consolefontans
    if [ -z "$consolefontans" ]
    then
    choicexit
    fi
    case $consolefontans in
    s)
    ;;
    sk)
    consolefont=
    ;;
    *)
    consolefont=$consolefontans
    ;;
    esac
}
################################
################################        TIMEZONE FUNC
################################
answertimezone(){
clear
answer='
        print timezone (example Europe/Moscow)

            or
            s) - skip
            d) - default (default Europe/London)
            empty) - exit without save

'
printgraph
printanswer
read -p "       Your choice: " timezoneans
    if [ -z "$timezoneans" ]
    then
    choicexit
    fi
    case $timezoneans in
    s)
    ;;
    d)
    timezone="Europe/London"
    ;;
    *)
    timezone=$timezoneans
    ;;
    esac
}
################################
################################        USER FUNC
################################
answeruser(){
clear
answer='
        print username

            or
            s) - skip
            empty) - exit without save

'
printgraph
printanswer
read -p "       Your choice: " usernameans
    if [ -z "$usernameans" ]
    then
    choicexit
    fi
    case $usernameans in
    s)
    ;;
    *)
    username=$usernameans
    ;;
    esac
}
################################
################################        HOST FUNC
################################
answerhost(){
clear
answer="
        print hostname

            or
            s) - skip
            empty) - exit without save

"
printgraph
printanswer
read -p "       Your choice: " hostnameans
    if [ -z $hostnameans ]
    then
    choicexit
    fi
    case $hostnameans in
    s)
    ;;
    *)
    hostname=$hostnameans
    ;;
    esac
}
################################
################################        INIT FUNC
################################
answerinitsystem(){
clear
answer='
        choose init system

            1) - runit
            2) - openrc
            any) - exit without save
            (only runit and openrc for now)

'
printgraph
printanswer
read -p "       Your choice: " initsystemans
    case $initsystemans in
    1)
    initsystem=runit
    ;;
    2)
    initsystem=openrc
    ;;
    *)
    choicexit
    ;;
    esac
}
################################
################################        KERNEL FUNC
################################
answerkernel(){
clear
answer='
        choose kernel

            1) - linux
            2) - linux-zen
            3) - linux-lts
            any) - exit without save

'
printgraph
printanswer
read -p "       Your choice: " kernelans
    case $kernelans in
    1)
    kernel=linux
    ;;
    2)
    kernel=linux-zen
    ;;
    3)
    kernel=linux-lts
    ;;
    *)
    choicexit
    ;;
    esac
}
################################
################################        SYSTEM-EFI-BIOS FUNC
################################
answersystemadd(){
    case $system in
    BIOS)
    clear
    answer='
        choice disk for grub ( /dev/sd* )

            or
            s) - skip
            empty) - exit without save

    '
    printgraph
    printanswer
    lsblk
    echo " "
    read -p "       Your choice: " biosdiskans
        if [ -z "$biosdiskans" ]
        then
        choicexit
        fi
        case $biosdiskans in
        s)
        ;;
        *)
        biosdisk=$biosdiskans
        ;;
        esac
    ;;
    EFI)
    clear
    answer='
        print bootloader name

            or
            s) - skip
            d) - default (grub)
            empty) - exit without save

    '
    printgraph
    printanswer
    read -p "       Your choice: " efibootans
    echo " "
        if [ -z "$efibootans" ]
        then
        choicexit
        fi
        case $efibootans in
        s)
        ;;
        d)
        efiboot=grub
        ;;
        *)
        efiboot=$efibootans
        ;;
        esac
    ;;
    esac
}
################################
################################        NETWORK FUNC
################################
answernetwork(){
clear
answer='
        print network manager

            or
            s) - skip
            d) - default (networkmanager)
            empty) - exit with no changes

'
printgraph
printanswer
read -p "       Your choice: " networkans
    if [ -z "$networkans" ]
    then
    choicexit
    fi
    case $networkans in
    s)
    ;;
    d)
    network=networkmanager
    ;;
    *)
    network=$networkans
    ;;
    esac
}
################################
################################        DESKTOP FUNC
################################
answerdesktop(){
clear
answer='
        print desktop environment

            (gnome, plasma, lxqt, lxde or another)
            s) - skip
            sk) if you already print, but want delete
            empty) - exit with no changes

'
printgraph
printanswer
read -p "       Your choice: " desktopans
    if [ -z "$desktopans" ]
    then
    choicexit
    fi
    case $desktopans in
    s)
    ;;
    sk)
    desktop=
    ;;
    *)
    desktop=$desktopans
    ;;
    esac
}
################################
################################        DISPLAY FUNC
################################
answerdisplay(){
clear
answer='
        print display manager

            (sddm, lightdm, gdm or another)
            s) - skip
            sk) if you already print, but want delete
            empty) - exit with no changes

'
printgraph
printanswer
read -p "       Your choice: " displayans
    if [ -z "$displayans" ]
    then
    choicexit
    fi
    case $displayans in
    s)
    ;;
    sk)
    display=
    ;;
    *)
    display=$displayans
    ;;
    esac
}
################################
################################        FUNC-EXTRAPACKAGES
################################
answerextrapackages(){
clear
answer='
       print additional packages

            (nano, kate, falkon or another)
            s) - skip
            empty) - exit with no changes

'
printgraph
printanswer
read -p "       Your choice: " extrapackagesans
    if [ -z $extrapackagesans ]
    then
    choicexit
    fi
    case $extrapackagesans in
    s)
    ;;
    sk)
    extrapackages=
    ;;
    *)
    extrapackages="$extrapackagesans"
    ;;
    esac
}
################################
################################
################################
answerready(){
clear
answer='
       Are you sure?

         yes) - contunue
         any) - retry
         empty) - exit with no changes

'
printgraph
printanswer
read -p "       Your choice: " readyans
    if [ -z $readyans ]
    then
    choicexit
    fi
    if [ $readyans = yes ]
    then
    ready=1
    fi
}

################################
################################        PASSWORD FUNC
################################

answerpassroot(){
    clear
    correct=no
    answer="
       print root password
    "
    until [ $correct = yes ]
        do
        clear
        printanswer
        artix-chroot /mnt passwd
        read -p "Do you enter pass correctly (yes/no)? : " correct
        done
}

answerpassuser(){
    clear
    correct=no
    answer="
       print root password
    "
    artix-chroot /mnt useradd -m -g users -G wheel -s /bin/bash $username
    echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers
    until [ $correct = yes ]
        do
        clear
        printanswer
        artix-chroot /mnt passwd $username
        read -p "Do you enter pass correctly (yes/no)? : " correct
        done
}

################################
################################        ENDING FUNC
################################

answerending(){
    clear
    answer='
       Do you want reboot or...

         1)Enter livecd
         2)Enter artix-chroot (reboot after exit)
         any) - reboot
    '
    printanswer
    read -p "       Your choice: " endingans
    case $endingans in
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
}

################################
################################        LIST OF FUNCTIONS
################################
# answersystem
# answerlocale
# answerfont
# answertimezone
# answeruser
# answerhost
# answerinitsystem
# answerkernel
# answersystemadd
# answernetwork
# answerdesktop
# answerdisplay
# answerextrapackages
# answerready

#       AFTER READY

# answerpassroot
# answerpassuser
# answerending

################################
################################        MAIN
################################
ready=0
while [ $ready = 0 ]
do
answersystem
answerlocale
answerfont
answertimezone
answeruser
answerhost
answerinitsystem
answerkernel
answersystemadd
answernetwork
answerdesktop
answerdisplay
answerextrapackages
answerready
done

if [ $ready = 1 ]
then
############################################################        INSTALL
################################

############################################################        BASESTRAP-BASE-INIT
################################

    basestrap /mnt base base-devel $initsystem elogind-$initsystem

############################################################
################################        BASESTRAP-NETWORK

    basestrap /mnt $network $network"-"$initsystem dhcpcd

############################################################
################################        BASESTRAP-KERNEL

    basestrap /mnt $kernel $kernel-headers linux-firmware

############################################################
################################        BASESTRAP-GRUB

    basestrap /mnt grub os-prober efibootmgr

############################################################
################################        BASESTRAP-DESKTOP

    if [ -n "$desktop" ]
    then
    basestrap /mnt $desktop
    fi

########################################################
################################        BASESTRAP-DISPLAY

    if [ -n "$display" ]
    then
    basestrap /mnt $display $display"-"$initsystem
    fi

########################################################
################################        BASESTRAP-EXTRA

    if [ -n "$extrapackages" ]
    then
    basestrap /mnt $extrapackages
    fi

########################################################
################################        HOSTNAME

        case $initsystem in
        runit)
        echo $hostname > /mnt/etc/hostname
        ;;
        openrc)
        echo $hostname > /mnt/etc/hostname
        echo "hostname=$hostname" > /mnt/etc/conf.d/hostname
        ;;
        esac

########################################################
################################        HOSTS

    echo "127.0.1.1 localhost.localdomain $hostname" >> /mnt/etc/hosts

########################################################
################################        CONSOLEFONT

        if [ $consolefont != skipped ]
        then
        case $initsystem in
            runit)
            echo "FONT=$consolefont" > /mnt/etc/vconsole.conf
            ;;
            openrc)
            artix-chroot /mnt rc-update add consolefont boot
            echo "consolefont=\"$consolefont\"" > /mnt/etc/conf.d/consolefont
            ;;
            esac
        fi

########################################################
################################        LOCAL

    echo LANG="$locale.UTF-8" > /mnt/etc/locale.conf
    echo "LC_COLLATE="C"" >> /mnt/etc/locale.conf

########################################################
################################        LOCALE-GEN

        if [ $locale == en_US ]
        then
        echo $locale.UTF-8 UTF-8 >> /mnt/etc/locale.gen
        else
        echo $locale.UTF-8 UTF-8 >> /mnt/etc/locale.gen
        echo en_US.UTF-8 UTF-8 >> /mnt/etc/locale.gen
        fi
        artix-chroot /mnt locale-gen

########################################################
################################        FSTAB

    fstabgen -U /mnt >> /mnt/etc/fstab

########################################################
################################        TIMEZONE

    artix-chroot /mnt ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
    artix-chroot /mnt hwclock --systohc

########################################################
################################        GRUB

        case $system in
        BIOS)
        artix-chroot /mnt grub-install --recheck $biosdisk
        artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
        ;;
        EFI)
        artix-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=$efiboot
        artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
        ;;
        esac

########################################################
################################        AUTOSTART
########################################################
################################        AUTOSTART-NETWORK

    case $initsystem in
        runit)
        case $network in
            networkmanager)
            artix-chroot /mnt ln -s /etc/runit/sv/NetworkManager /etc/runit/runsvdir/default
            ;;
            connman)
            artix-chroot /mnt ln -s /etc/runit/sv/connmand/ /etc/runit/runsvdir/default
            ;;
        esac
        ;;
        openrc)
        case $network in
            networkmanager)
            artix-chroot /mnt rc-update add NetworkManager
            ;;
            connman)
            artix-chroot /mnt rc-update add connmand
            ;;
        esac
        ;;
    esac

########################################################
################################        AUTOSTART-DISPLAY

    if [ -n $display ]
    then
        case $initsystem in
        runit)
        artix-chroot /mnt ln -s /etc/runit/sv/$display /etc/runit/runsvdir/default
        ;;
        openrc)
        artix-chroot /mnt rc-update add $display
        ;;
        esac
    fi

########################################################
################################        PASS

    answerpassroot
    answerpassuser

########################################################
################################        ENDING

    answerending

fi
