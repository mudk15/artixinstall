#!/bin/bash
echo "ln -sf /usr/share/zoneinfo/\$tmzn /etc/localtime
hwclock --systohc
locale-gen
echo your system is 1 - BIOS, 2 - EFI?
read syst
case \$syst in
1)
echo choice disk for bios
lsblk
read diskbios
grub-install --recheck \$diskbios
grub-mkconfig -o /boot/grub/grub.cfg
;;
2)
echo print bootloader id
read bootid
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=\$bootid
grub-mkconfig -o /boot/grub/grub.cfg
;;
esac
echo print root password
passwd
echo print username
read usrnm
useradd -m -g users -G wheel -s /bin/bash \$usrnm
echo %wheel ALL=(ALL) ALL >> /etc/sudoers
echo print pass for \$usrnm
passwd \$usrnm
case \$initsys in
runit)
ln -s /etc/runit/sv/NetworkManager/ /etc/runit/runsvdir/default
;;
openrc)
rc-update add NetworkManager
;;
esac
exit" >> ./continue.sh
