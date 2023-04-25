# keymap
sudo localectl set-keymap dvorak

# e1000e
sha256sum e1000e.ko
xz e1000e.ko
sudo mv e1000e.ko.xz $(find /lib/modules -name e1000e)
sudo modprobe -r e1000e
sudo modprobe e1000e
sudo dracut --force
modinfo e1000e | head

# dnf
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
sudo sed -e 's|^metalink=|#metalink=|g'          -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g'          -i.bak          /etc/yum.repos.d/fedora.repo          /etc/yum.repos.d/fedora-modular.repo          /etc/yum.repos.d/fedora-updates.repo          /etc/yum.repos.d/fedora-updates-modular.repo
sudo dnf update

# btrfs
sudo lsblk -p
sudo chattr -R +C /var/lib/libvirt /var/lib/mariadb /var/lib/pgsql /var/lib/mysql

# snapper
sudo dnf install snapper python3-dnf-plugin-snapper inotify-tools
sudo umount /.snapshots
sudo rmdir /.snapshots/
suod snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots/
sudo mkdir /.snapshots
sudo systemctl daemon-reload
sudo mount -a
lsblk -p
sudo snapper -c root set-config ALLOW_USERS=$USER SYNC_ACL=yes
sudo chown -R :$USER /.snapshots

# e1000e
install_v=$(dnf list kernel --installed | tail -n 1 | awk '{print $2}' | cut -d '-' -f 1) # 6.2.10
install_v_2=$(echo $install_v | cut -d '.' -f 1,2) # 6.2
install_v_1=$(echo $install_v | cut -d '.' -f 1) # 6

cd $HOME/Downloads/linux-kernel-source
# major update, download source code
wget https://cdn.kernel.org/pub/linux/kernel/v$install_v_1.x/linux-$install_v.tar.xz && unxz linux-$install_v.tar.xz
wget https://cdn.kernel.org/pub/linux/kernel/v$install_v_1.x/linux-$install_v.tar.sign
gpg2 --verify linux-$install_v.tar.sign
tar xf linux-$install_v.tar

cd /usr/src
sudo mkdir e1000e-$install_v && cd e1000e-$install_v
sudo cp -rT $(find $HOME/Downloads/linux-kernel-source/linux-$install_v -name e1000e) src/
sudo cp $HOME/code/dotfiles/fedora/dkms.conf ./
sudo sed -i "s/package_version/$install_v/g" dkms.conf
sudo sed -i '/e1000_validate_nvm_checksum/d' src/netdev.c
echo "\nall:\n\tmake -C /lib/modules/\$(KVERSION)/build M=\$(shell pwd) module" | sudo tee -a src/Makefile
echo "\nclean:\n\tmake -C /lib/modules/\$(KVERSION)/build M=\$(shell pwd) clean" | sudo tee -a src/Makefile
sudo reboot
sudo dkms add -m e1000e -v $install_v
sudo dkms install -m e1000e -v $install_v --force
modinfo e1000e | head -n1
sudo dracut -f
sudo reboot

# clash
cd /tmp
wget https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb
wget -O config.yaml {link}
sudo mkdir -p /etc/clash
sudo cp config.yaml Country.mmdb /etc/clash
sudo vi /etc/systemd/system/clash.service     ### https://github.com/Dreamacro/clash/wiki/Running-Clash-as-a-service
sudo systemctl daemon-reload
sudo systemctl enable clash
sudo systemctl start clash
journalctl -xe | tail    # http://clash.razord.top/

# github
sudo dnf install gh
gh auth login


