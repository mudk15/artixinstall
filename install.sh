#!/bin/bash

#####################       FUNCTIONS_BEGIN

#####################       FUNCTION_SYSTEM_MODE

check_system(){
system_mode=$(cat /sys/firmware/efi/fw_platform_size)
if [ "$system_mode" = 64 ]; then
system_mode=EFI
else
system_mode=BIOS
fi
}

#####################       FUNCTION_ANOTHER

choice_exit(){
echo -e "\n\texit\n"
exit
}
daemon_openrc_func(){
artix-chroot /mnt pacman -Ql $programm-openrc | grep init.d | sed '$!d' | sed "s/$programm-openrc etc\/init.d\///"
}
daemon_runit_func(){
artix-chroot /mnt pacman -Ql $programm-runit | grep run$ | sed "s/$programm-runit //" | sed "s/run$//"
}

#####################       FUNCTION_GRAPHICAL

print_upper(){
echo -e "    ┌───────────────────────────────────────────────────────────────────┐"
}
print_lower(){
echo -e "    └───────────────────────────────────────────────────────────────────┘"
}
print_graph(){
echo -e "\tyour choice\n
\tbios mode               - $system_mode"
if [ ! -z $partition_tool ]; then
echo -e "\tmount tool              - $partition_tool
\tdisk to partitioning    - $partition_disk"
fi
if [ ! -z $filesystem_fs ]; then
echo -e "\tfilesystem              - "$filesystem_fs"
\tdisk to format          - $filesystem_disk"
fi
if [ ! -z $mounting_where ]; then
echo -e "\tWhere to mount?         - $mounting_where
\tWhat to mount?          - $mounting_what"
fi
if [ -z $stady_system_mount ]; then
lsblk -o NAME,SIZE,FSTYPE,FSVER,MOUNTPOINTS | sed '1d' | sed 's/^/\t/' | sed '1s/^/\n/' | sed '$s/$/\n/'
fi
if [ "$system_mode" = EFI ]
then
echo -e "\t(EFI) bootloader name*  - $efi_boot"
else
echo -e "\t(BIOS) disk for grub*   - $bios_disk"
fi
echo -e "\tlocale*                 - $locale
\tconsole font            - $console_font
\ttimezone*               - $timezone
\tuser*                   - $username
\thostname*               - $hostname
\tinit system*            - $initsystem
\tkernel*                 - $kernel
\tnetwork*                - $network
\tdesktop environment     - $desktop
\tdisplay manager         - $display
\tadditional packages     - $extra_packages
\t* - Required field"
}

print_full(){
clear
print_upper
print_graph
print_lower
}

print_scheme(){
if [ $system_mode = EFI ]; then
echo -e "\tMinimal scheme for EFI is
\t1. EFI system partition in FAT32 ( minimal 100MB) /mnt/boot/efi
\t2. Linux root (x84_64) /mnt\n"
else
echo -e "\tMinimal scheme for BIOS
\t1.root ( 83 Linux ) partition with boot flag /mnt\n"
fi
}
#####################       FUNCTION_ANSWERS

answer_ready(){
print_full
print_upper
echo -e "\tAre you sure?\n
\tyes) - continue
\tno) - restart
\tany) - exit without change"
print_lower
read -p "
        Your choice: " ready_answer
if [ -z $ready_answer ]; then
choice_exit
else
    case $ready_answer in
    yes)
    ready=1
    ;;
    no)
    ready=
    ;;
    *)
    choice_exit
    ;;
    esac
fi
}

answer_ready_cycle(){
print_full
print_upper
echo -e "$answer_cycle"
echo -e "\tyes) - continue
\tno) - restart
\tany) - exit without change"
print_lower
read -p "
        Your choice: " ready_cycle_answer
if [ -z $ready_cycle_answer ]; then
choice_exit
else
    case $ready_cycle_answer in
    yes)
    ready_cycle=1
    ;;
    no)
    ready_cycle=
    ;;
    *)
    choice_exit
    ;;
    esac
fi
}

answer_system(){
print_full
print_upper
echo -e "\tCurrent mode is $system_mode
\tDo you want change to another?\n
\tyes) - EFI > BIOS or vice versa
\tno) - skip
\tany or empty) - exit without save"
print_lower
read -p "
        Your choice: " answer
case $answer in
yes)
    if [ $system_mode = EFI ]; then
    system_mode=BIOS
    else
    system_mode=EFI
    fi
;;
no)
;;
*)
choice_exit
;;
esac
}

answer_system_add(){
case $system_mode in
EFI)
print_full
print_upper
echo -e "\tPrint bootloader name or
\td) - default (grub)
\ts) - skip
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    d)
    efi_boot=grub
    ;;
    s)
    ;;
    *)
    efi_boot=$answer
    ;;
    esac
fi
;;
BIOS)
print_full
print_upper
echo -e "\tPrint disk for grub ( sd* ) or
\ts) - skip
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    *)
    bios_disk=$answer
    ;;
    esac
fi
;;
esac
}

answer_partition_tool(){
print_full
print_upper
print_scheme
echo -e "\tPrint partition tool"
ls /usr/bin/ | grep disk$ | sed 's/^/\t/' | sed 's/cfdisk/cfdisk (recommended)/'
ls /usr/bin/ | grep parted$ | sed 's/^/\t/'
echo -e "\ts) - skip
\tc) - clear
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    partition_tool=
    ;;
    *)
    partition_tool=$answer
    ;;
    esac
fi
}

answer_partition_disk(){
print_full
print_upper
print_scheme
echo -e "\tPrint disk to partitioning ( sd* )
\ts) - skip
\tc) - clear
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    partition_disk=
    ;;
    *)
    partition_disk="/dev/$answer"
    ;;
    esac
fi
}

answer_filesystem_fs(){
print_full
print_upper
print_scheme
echo -e "\tPrint filesystem to format + options"
ls /usr/bin/ | grep mkfs | sed '1d' | sed '/dos/d' | sed '/s.fat/d' | sed 's/mkfs.//' | sed 's/^/\t/'
echo -e "\ts) - skip
\tc) - clear
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer filesystem_option
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    filesystem_fs=
    ;;
    *)
    filesystem_fs=$answer
    ;;
    esac
fi
}

answer_filesystem_disk(){
print_full
print_upper
print_scheme
echo -e "\tPrint partition to format ( sd(a-z)* )
\ts) - skip
\tc) - clear
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    filesystem_disk=
    ;;
    *)
    filesystem_disk="/dev/$answer"
    ;;
    esac
fi
}

answer_mounting_where(){
print_full
print_upper
print_scheme
echo -e "\tPrint where to mount disk
\tFor example
\t/) - root
\t/boot/efi) - efi (for EFI)
\t/home - home directory
\ts) - skip
\tc) - clear
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    mounting_where=
    ;;
    *)
    mounting_where="/mnt$answer"
    ;;
    esac
fi
}

answer_mounting_what(){
print_full
print_upper
print_scheme
echo -e "\tPrint partition to mount ( sd(a-z)* )
\ts) - skip
\tc) - clear
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    mounting_what=
    ;;
    *)
    mounting_what="/dev/$answer"
    ;;
    esac
fi
}

answer_locale(){
print_full
print_upper
echo -e "\tPrint locale (example ru_RU for Russian)\n
\tor print
\ts) - skip
\td) - default (en_US)
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    d)
    locale="en_US"
    ;;
    *)
    locale="$answer"
    ;;
    esac
fi
}

answer_console_font(){
print_full
print_upper
echo -e "\tprint console font (cyr-sun16 for russian) or\n
\ts) - skip
\tc) - clear
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    console_font=
    ;;
    *)
    console_font="$answer"
    ;;
    esac
fi
}

answer_timezone(){
print_full
print_upper
echo -e "\tprint timezone (example Europe/Moscow) or\n
\ts) - skip
\td) - default (default Europe/London)
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    d)
    timezone="Europe/Moscow"
    ;;
    *)
    timezone="$answer"
    ;;
    esac
fi
}

answer_username(){
print_full
print_upper
echo -e "\tPrint username or\n
\ts) - skip
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    *)
    username="$answer"
    ;;
    esac
fi
}

answer_hostname(){
print_full
print_upper
echo -e "\tPrint hostname or\n
\ts) - skip
\tempty) - exit without save"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    *)
    hostname="$answer"
    ;;
    esac
fi
}

answer_initsystem(){
print_full
print_upper
echo -e "\tChoose init system\n
\ts) - skip
\t1) - runit
\t2) - openrc
\tany) - exit without save
\t(only runit and openrc for now)"
print_lower
read -p "
        Your choice: " answer
case $answer in
    s)
    ;;
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

answer_kernel(){
print_full
print_upper
echo -e "\tChoose kernel\n
\ts) - skip
\t1) - linux
\t2) - linux-zen
\t3) - linux-lts
\tany) - exit without save"
print_lower
read -p "
        Your choice: " answer
case $answer in
    s)
    ;;
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

answer_network(){
print_full
print_upper
echo -e "\tPrint network manager or\n
\ts) - skip
\td) - default (networkmanager)
\tempty) - exit with no changes"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    d)
    network="networkmanager"
    ;;
    *)
    network="$answer"
    ;;
    esac
fi
}

answer_desktop(){
print_full
print_upper
echo -e "\tprint desktop environment\n
\t(gnome, plasma, lxqt, lxde or another)
\ts) - skip
\tc) - clear
\tempty) - exit with no changes"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    desktop=
    ;;
    *)
    desktop="$answer"
    ;;
    esac
fi
}

answer_display(){
print_full
print_upper
echo -e "\tPrint display manager\n
\t(sddm, lightdm, gdm or another)
\ts) - skip
\tc) - clear
\tempty) - exit with no changes"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    display=
    ;;
    *)
    display="$answer"
    ;;
    esac
fi
}

answer_extra_packages(){
print_full
print_upper
echo -e "\tPrint additional packages\n
\t(nano, kate, falkon or another)
\ts) - skip
\tc) - clear
\tempty) - exit with no changes"
print_lower
read -p "
        Your choice: " answer
if [ -z $answer ]; then
choice_exit
else
    case $answer in
    s)
    ;;
    c)
    extra_packages=
    ;;
    *)
    extra_packages="$answer"
    ;;
    esac
fi
}

answer_pass_root(){
correct=no
    until [ $correct = yes ]
    do
        print_full
        print_upper
        echo -e "\tPrint root password"
        print_lower
        artix-chroot /mnt passwd
        read -p "Do you enter pass correctly (yes/no)? : " correct
    done
}

answer_password_user(){
correct=no
artix-chroot /mnt useradd -m -g users -G wheel -s /bin/bash $username
sed -i '82s/# //' /mnt/etc/sudoers
    until [ $correct = yes ]
    do
        print_full
        print_upper
        echo -e "\tPrint $username password"
        print_lower
        artix-chroot /mnt passwd $username
        read -p "Do you enter pass correctly (yes/no)? : " correct
    done
}

answer_ending(){
print_full
print_upper
echo -e "\tDo you want reboot or\n
\t1)Enter livecd
\t2)Enter artix-chroot (reboot after exit)
\tany) - reboot"
print_lower
read -p "
        Your choice: " answer
case $answer in
    1)
    clear
    choice_exit
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

#####################
check_system
#####################       CYCLE_SYSTEM_MODE
    ready=
    while [ -z $ready ]
    do
    answer_system
    answer_ready
    done
#####################       CYCLE_PARTITIONING
ready_cycle=
answer_cycle="\tHave you finished partitioning?\n"
while [ -z $ready_cycle ]
do
ready=
    while [ -z $ready ]
    do
    answer_partition_tool
    answer_partition_disk
    answer_ready
    done
if [[ ! -z $partition_tool && ! -z $partition_disk ]]; then
$partition_tool $partition_disk
fi
answer_ready_cycle
done
#####################   `   CYCLE_FORMAT
partition_tool=
ready_cycle=
answer_cycle="\tHave you finished formatting?\n"
while [ -z $ready_cycle ]
do
ready=
    while [ -z $ready ]
    do
    answer_filesystem_fs
    answer_filesystem_disk
    answer_ready
    done
if [[ ! -z $filesystem_fs && ! -z $filesystem_disk ]]; then
    if [ -z $filesystem_option ]; then
    mkfs.$filesystem_fs $filesystem_disk
    else
    mkfs.$filesystem_fs $filesystem_option $filesystem_disk
    fi
fi
answer_ready_cycle
done
#####################       CYCLE_MOUNT
filesystem_fs=
ready_cycle=
answer_cycle="\tHave you finished mounting?\n"
while [ -z $ready_cycle ]
do
ready=
    while [ -z $ready ]
    do
    answer_mounting_where
    answer_mounting_what
    answer_ready
    done
if [[ ! -z $mounting_what && ! -z $mounting_where ]]; then
umount $mounting_what
mkdir -p $mounting_where
mount $mounting_what $mounting_where
fi
answer_ready_cycle
done
#####################       CYCLE_MAIN
mounting_where=
ready_cycle=
answer_cycle="\tAre you sure?\n"
while [[ -z $ready_cycle && -z $locale && -z $timezone && -z $username && -z $hostname && -z $initsystem && -z $kernel && -z $network && -z $system_add_var ]]
do
answer_system_add
    case $system_mode in
    EFI)
        if [ ! -z $efi_boot ]; then
        system_add_var=1
        else
        system_add_var=
        fi
    ;;
    BIOS)
         if [ ! -z $bios_disk ]; then
        system_add_var=1
        else
        system_add_var=
        fi
    ;;
    esac
answer_locale
answer_console_font
answer_timezone
answer_username
answer_hostname
answer_initsystem
answer_kernel
answer_network
answer_desktop
answer_display
answer_extra_packages
answer_ready_cycle
done
#####################       INSTALLATION
if [ $ready_cycle = 1 ]; then

#####################       BASESTRAP-BASE-INIT

    basestrap /mnt base base-devel $initsystem elogind-$initsystem

#####################       BASESTRAP-NETWORK

    basestrap /mnt $network $network"-"$initsystem dhcpcd

#####################       BASESTRAP-KERNEL

    basestrap /mnt $kernel $kernel-headers linux-firmware

#####################       BASESTRAP-GRUB

    basestrap /mnt grub os-prober efibootmgr

#####################       BASESTRAP-DESKTOP

    if [ ! -z "$desktop" ]
    then
    basestrap -i /mnt $desktop
    fi

#####################       BASESTRAP-DISPLAY

    if [ ! -z "$display" ]
    then
    basestrap -i /mnt $display $display"-"$initsystem
    fi

#####################       BASESTRAP-EXTRA

    if [ ! -z "$extra_packages" ]
    then
    basestrap -i /mnt $extra_packages
    fi

#####################       HOSTNAME

        case $initsystem in
        runit)
        echo $hostname > /mnt/etc/hostname
        ;;
        openrc)
        echo $hostname > /mnt/etc/hostname
        echo "hostname=$hostname" > /mnt/etc/conf.d/hostname
        ;;
        esac

#####################       HOSTS

    echo "127.0.1.1 localhost.localdomain $hostname" >> /mnt/etc/hosts

#####################       CONSOLE-FONT

        if [ ! -z $console_font ]
        then
        case $initsystem in
            runit)
            echo "FONT=$console_font" > /mnt/etc/vconsole.conf
            ;;
            openrc)
            artix-chroot /mnt rc-update add consolefont boot
            echo "FONT=$console_font" > /mnt/etc/vconsole.conf
            echo "consolefont=\"$console_font\"" > /mnt/etc/conf.d/consolefont
            ;;
            esac
        fi

#####################       LOCALE

    echo LANG="$locale.UTF-8" > /mnt/etc/locale.conf
    echo "LC_COLLATE="C"" >> /mnt/etc/locale.conf

#####################       LOCALE-GEN

        if [ $locale = en_US ]
        then
        sed -i "s/#$locale.UTF-8/$locale.UTF-8/" /mnt/etc/locale.gen
        else
        sed -i "s/#$locale.UTF-8/$locale.UTF-8/" /mnt/etc/locale.gen
        sed -i "s/#en_US.UTF-8/en_US.UTF-8/" /mnt/etc/locale.gen
        fi
        artix-chroot /mnt locale-gen

#####################       FSTAB

    fstabgen -U /mnt >> /mnt/etc/fstab

#####################       TIMEZONE

    artix-chroot /mnt ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
    artix-chroot /mnt hwclock --systohc

#####################       GRUB

        case $system_mode in
        BIOS)
        artix-chroot /mnt grub-install --recheck $bios_disk
        artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
        ;;
        EFI)
        artix-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=$efi_boot
        artix-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
        ;;
        esac

#####################       AUTOSTART
#####################       AUTOSTART-NETWORK

    programm=$network
    case $initsystem in
        runit)
            artix-chroot /mnt ln -s `daemon_runit_func` /etc/runit/runsvdir/default
        ;;
        openrc)
            artix-chroot /mnt rc-update add `daemon_openrc_func`
        ;;
    esac

#####################       AUTOSTART-DISPLAY

    if [ ! -z $display ]
    then
    programm=$display
        case $initsystem in
        runit)
            artix-chroot /mnt ln -s `daemon_runit_func` /etc/runit/runsvdir/default
        ;;
        openrc)
            artix-chroot /mnt rc-update add `daemon_openrc_func`
        ;;
        esac
    fi

#####################       PASS
#####################       PASS-ROOT

    answer_pass_root
    answer_password_user

#####################       PASS-USER

    answer_ending
fi
