# artixinstall
1. Partition and mount disks
2. Choose variant
    1. Git
        1. Enter livecd
        2. Enter root (su)
        3. pacman -Sy git
        4. git clone https://github.com/mudk15/artixinstall
        5. cd artixinstall
        6. ./script.sh
    2. Wget
```bash
pacman -Sy git;git clone https://github.com/mudk15/artixinstall;cd artixinstall;./script.sh
```
```bash
pacman -Sy wget;wget https://raw.githubusercontent.com/mudk15/artixinstall/main/script.sh;chmod 777 script.sh;./script.sh
```
