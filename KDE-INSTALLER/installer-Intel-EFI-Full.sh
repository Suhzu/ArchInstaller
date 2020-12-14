#!/bin/bash

	
	timedatectl set-timezone Europe/Amsterdam
	locale-gen
	echo LANG=en_US.UTF-8 > /etc/locale.conf
	export LANG=en_US.UTF-8
	cat /etc/hosts
	sleep 10
	clear
	echo "Installer: Setup Root Password"
	passwd
	pacman -S xorg xorg-server intel-ucode amd-ucode xf86-video-intel --noconfirm
	
	
	clear
	pacman -S firefox konsole --noconfirm
	pacman -S sddm plasma plasma-wayland-session kde-applications networkmanager --noconfirm
	systemctl enable sddm
	systemctl enable NetworkManager.service
	
	mkdir /boot/efi
	mount /dev/sda1 /boot/efi
	pacman -S grub efibootmgr --noconfirm
	
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
	
	grub-mkconfig -o /boot/grub/grub.cfg
	
	clear
	echo "Installer: add user with useradd -m username"
	echo "Installer: then passwd username"
