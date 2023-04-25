# e1000e
current_v=$(uname -r | cut -d '-' -f 1) # 6.2.11
install_v=$(dnf list kernel --installed | tail -n 1 | awk '{print   $2}' | cut -d '-' -f 1) # 6.2.10
current_v_2=$(echo $current_v | cut -d '.' -f 1,2) # 6.2
install_v_2=$(echo $install_v | cut -d '.' -f 1,2) # 6.2
install_v_1=$(echo $install_v | cut -d '.' -f 1) # 6

cd $HOME/Downloads/linux-kernel-source
if [ $install_v_2 = $current_v_2]; then
    # minor update, download patch
    wget https://cdn.kernel.org/pub/linux/kernel/v$install_v_1.x/   patch-$install_v.xz
    unxz patch-$install_v.xz
    cd linux-$current_v
    patch -p1 -R < ../patch-$current_v
    patch -p1  < ../patch-$install_v
    cd .. && mv linux-$current_v linux-$install_v
else
    # major update, download source code
    wget https://cdn.kernel.org/pub/linux/kernel/v$install_v_1.x/   linux-$install_v.tar.xz && unxz linux-$install_v.tar.xz
    wget https://cdn.kernel.org/pub/linux/kernel/v$install_v_1.x/   linux-$install_v.tar.sign
    gpg2 --verify linux-$install_v.tar.sign
    tar xf linux-$install_v.tar
fi

# install dkms module
cd /usr/src
sudo mkdir e1000e-$install_v && cd e1000e-$install_v
sudo cp -rT $(find $HOME/Downloads/linux-kernel-source/linux-       $install_v -name e1000e) src/
sudo cp $HOME/code/dotfiles/fedora/dkms.conf ./
sudo sed -i "s/package_version/$install_v/g" dkms.conf
sudo sed -i '/e1000_validate_nvm_checksum/d' src/netdev.c
echo "\nall:\n\tmake -C /lib/modules/\$(KVERSION)/build M=\$(shell  pwd) module" | sudo tee -a src/Makefile
echo "\nclean:\n\tmake -C /lib/modules/\$(KVERSION)/build M=\$(shell  pwd) clean" | sudo tee -a src/Makefile
sudo reboot

sudo dkms add -m e1000e -v $install_v
sudo dkms install -m e1000e -v $install_v --force
modinfo e1000e | head -n1
sudo dracut -f
sudo reboot
