#!/bin/bash
################################
################################        CHECK_SYSTEM
################################
check_system(){
system=$(cat /sys/firmware/efi/fw_platform_size)
if [ "$system" = 64 ]
then
system=EFI
else
system=BIOS
fi
}
################################
################################        CHOICE_EXIT
################################
choice_exit(){
echo "
       exit without save
"
exit
}
################################
################################        TEST INIT DAEMONS
################################
daemon_openrc_func(){
pacman -Ql $programm-openrc | grep init.d | sed '$!d' | sed "s/$programm-openrc etc\/init.d\///"
}
daemon_runit_func(){
pacman -Ql $programm-runit | grep run$ | sed "s/$programm-runit //" | sed "s/run$//"
}
################################
################################        PRINT_GRAPH
################################
print_graph(){
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
print_answer(){
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
answer_system(){
clear
answer="
        script detected $system mode

            Do you want change to another?
            s) - skip
            yes) - EFI > BIOS or vice versa
            any) - exit without change

"
print_graph
print_answer
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
    choice_exit
    ;;
    esac
}
################################
################################        LOCALE FUNC
################################
answer_locale(){
clear
answer="
        print locale (example ru_RU for Russian)

            or print
            s) - skip
            d) - default (en_US)
            empty) - exit without save

"
print_graph
print_answer
read -p "       Your choice: " localeans
    if [ -z "$localeans" ]
    then
    choice_exit
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
answer_font(){
clear
answer='
        print console font (cyr-sun16 for russian)

            or
            s) - skip
            sk) if you already print, but want delete
            empty) - exit without save

'
print_graph
print_answer
read -p "       Your choice: " consolefontans
    if [ -z "$consolefontans" ]
    then
    choice_exit
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
answer_timezone(){
clear
answer='
        print timezone (example Europe/Moscow)

            or
            s) - skip
            d) - default (default Europe/London)
            empty) - exit without save

'
print_graph
print_answer
read -p "       Your choice: " timezoneans
    if [ -z "$timezoneans" ]
    then
    choice_exit
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
answer_user(){
clear
answer='
        print username

            or
            s) - skip
            empty) - exit without save

'
print_graph
print_answer
read -p "       Your choice: " usernameans
    if [ -z "$usernameans" ]
    then
    choice_exit
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
answer_host(){
clear
answer="
        print hostname

            or
            s) - skip
            empty) - exit without save

"
print_graph
print_answer
read -p "       Your choice: " hostnameans
    if [ -z $hostnameans ]
    then
    choice_exit
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
answer_initsystem(){
clear
answer='
        choose init system

            1) - runit
            2) - openrc
            any) - exit without save
            (only runit and openrc for now)

'
print_graph
print_answer
read -p "       Your choice: " initsystemans
    case $initsystemans in
    1)
    initsystem=runit
    ;;
    2)
    initsystem=openrc
    ;;
    *)
    choice_exit
    ;;
    esac
}
################################
################################        KERNEL FUNC
################################
answer_kernel(){
clear
answer='
        choose kernel

            1) - linux
            2) - linux-zen
            3) - linux-lts
            any) - exit without save

'
print_graph
print_answer
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
    choice_exit
    ;;
    esac
}
################################
################################        SYSTEM-EFI-BIOS FUNC
################################
answer_system_add(){
    case $system in
    BIOS)
    clear
    answer='
        choice disk for grub ( /dev/sd* )

            or
            s) - skip
            empty) - exit without save

    '
    print_graph
    print_answer
    lsblk
    echo " "
    read -p "       Your choice: " biosdiskans
        if [ -z "$biosdiskans" ]
        then
        choice_exit
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
    print_graph
    print_answer
    read -p "       Your choice: " efibootans
    echo " "
        if [ -z "$efibootans" ]
        then
        choice_exit
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
answer_network(){
clear
answer='
        print network manager

            or
            s) - skip
            d) - default (networkmanager)
            empty) - exit with no changes

'
print_graph
print_answer
read -p "       Your choice: " networkans
    if [ -z "$networkans" ]
    then
    choice_exit
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
answer_desktop(){
clear
answer='
        print desktop environment

            (gnome, plasma, lxqt, lxde or another)
            s) - skip
            sk) if you already print, but want delete
            empty) - exit with no changes

'
print_graph
print_answer
read -p "       Your choice: " desktopans
    if [ -z "$desktopans" ]
    then
    choice_exit
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
answer_display(){
clear
answer='
        print display manager

            (sddm, lightdm, gdm or another)
            s) - skip
            sk) if you already print, but want delete
            empty) - exit with no changes

'
print_graph
print_answer
read -p "       Your choice: " displayans
    if [ -z "$displayans" ]
    then
    choice_exit
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
answer_extra_packages(){
clear
answer='
       print additional packages

            (nano, kate, falkon or another)
            s) - skip
            empty) - exit with no changes

'
print_graph
print_answer
read -p "       Your choice: " extrapackagesans
    if [ -z $extrapackagesans ]
    then
    choice_exit
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
answer_ready(){
clear
answer='
       Are you sure?

         yes) - contunue
         any) - retry
         empty) - exit with no changes

'
print_graph
print_answer
read -p "       Your choice: " readyans
    if [ -z $readyans ]
    then
    choice_exit
    fi
    if [ $readyans = yes ]
    then
    ready=1
    fi
}

################################
################################        PASSWORD FUNC
################################

answer_pass_root(){
    clear
    correct=no
    answer="
       print root password
    "
    until [ $correct = yes ]
        do
        clear
        print_answer
        artix-chroot /mnt passwd
        read -p "Do you enter pass correctly (yes/no)? : " correct
        done
}

answer_password_user(){
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
        print_answer
        artix-chroot /mnt passwd $username
        read -p "Do you enter pass correctly (yes/no)? : " correct
        done
}

################################
################################        ENDING FUNC
################################

answer_ending(){
    clear
    answer='
       Do you want reboot or...

         1)Enter livecd
         2)Enter artix-chroot (reboot after exit)
         any) - reboot
    '
    print_answer
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
# answer_system
# answer_locale
# answer_font
# answer_timezone
# answer_user
# answer_host
# answer_initsystem
# answer_kernel
# answer_system_add
# answer_network
# answer_desktop
# answer_display
# answer_extra_packages
# answer_ready

#       AFTER READY

# answer_pass_root
# answer_password_user
# answer_ending

################################
################################        MAIN
################################
ready=0
check_system
while [ $ready = 0 ]
do
answer_system
answer_locale
answer_font
answer_timezone
answer_user
answer_host
answer_initsystem
answer_kernel
answer_system_add
answer_network
answer_desktop
answer_display
answer_extra_packages
answer_ready
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

        if [ -n $consolefont ]
        then
        case $initsystem in
            runit)
            echo "FONT=$consolefont" > /mnt/etc/vconsole.conf
            ;;
            openrc)
            artix-chroot /mnt rc-update add consolefont boot
            echo "FONT=$consolefont" > /mnt/etc/vconsole.conf
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

    programm=$network
    daemon_runit=$(daemon_runit_func)
    daemon_openrc=$(daemon_openrc_func)
    case $initsystem in
        runit)
            artix-chroot /mnt ln -s $daemon_runit /etc/runit/runsvdir/default
        ;;
        openrc)
            artix-chroot /mnt rc-update add $daemon_openrc
        ;;
    esac

########################################################
################################        AUTOSTART-DISPLAY

    if [ -n $display ]
    then
    programm=$display
    daemon_runit=$(daemon_runit_func)
    daemon_openrc=$(daemon_openrc_func)
        case $initsystem in
        runit)
            artix-chroot /mnt ln -s $daemon_runit /etc/runit/runsvdir/default
        ;;
        openrc)
            artix-chroot /mnt rc-update add $daemon_openrc
        ;;
        esac
    fi

########################################################
################################        PASS

    answer_pass_root
    answer_password_user

########################################################
################################        ENDING

    answer_ending

fi
