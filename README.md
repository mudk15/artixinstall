# artixinstall
1. Enter livecd
2. Enter root (su/sudo)
3. Partition, format and mount partitions
4. Choose variant
    * Git
        1. pacman -Sy git
        2. git clone https://github.com/mudk15/artixinstall
        3. cd artixinstall
        4. ./script.sh
    * Wget
        1. pacman -Sy wget
        2. wget https://raw.githubusercontent.com/mudk15/artixinstall/main/script.sh
        3. chmod 777 script.sh
        4. ./script.sh
## Git
```bash
pacman -Sy git;git clone https://github.com/mudk15/artixinstall;cd artixinstall;./script.sh
```
## Wget
```bash
pacman -Sy wget;wget https://raw.githubusercontent.com/mudk15/artixinstall/main/script.sh;chmod 777 script.sh;./script.sh
```
