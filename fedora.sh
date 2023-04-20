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

# dkms e1000e
sudo dnf in kernel-{version} kernel-devel-{version}
cd /tmp
curl -OL https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-{version}.tar.xz
curl -OL https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-{version}.tar.sign
gpg2 --locate-keys torvalds@kernel.org gregkh@kernel.org
unxz linux-{version}.tar.xz
gpg2 --verify linux-{version}.tar.sign
tar xf linux-{version}

install_v=
current_v=
cd $HOME/Downloads/linux-kernel-source
wget -O - https://cdn.kernel.org/pub/linux/kernel/v6.x/patch-${install_v}.xz && unxz patch-${install_v}.xz
cd linux-${current_v}
patch -p1 -R < ../patch-6.1.x
patch -p1  < ../patch-6.1.y
cd .. && mv linux-${current_v} linux-${install_v}

cd /usr/src
sudo mkdir e1000e-${current_v}
sudo cp -rT $(find $HOME/Downloads/linux-kernel-source/linux-${current_v} -name e1000e) src/
sudo cp e1000e-${current_v}/dkms.conf e1000e-${install_v}/dkms.conf
sudo cp e1000e-${current_v}/src/Makefile e1000e-${install_v}/src/Makefile
cd e1000e-${install_v}
sudo sed -i -e "s/${current_v}/${install_v}/g" dkms.conf
sudo vi src/netdev.c
sudo reboot
sudo dkms add -m e1000e -v 6.1.9
sudo dkms install -m e1000e -v 6.1.9 --force
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


