#!/bin/bash

echo "Welcome to arch installer uefi version"

fdisk -l

echo ""

echo "EFI should be at /dev/sda1"
echo "Swap should be at /dev/sda2"
echo "filesystem should be at /dev/sda3"
echo ""
echo "if not use nano or vim to change install.sh"
echo ""
read -p "Are you sure? " -n 1 -r
echo ""    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Confirmed"
	mkfs.fat -F32 /dev/sda1
    mkswap /dev/sda2
	mkfs.ext4 /dev/sda3
	mount /dev/sda3 /mnt
	pacman -Sy
	pacstrap /mnt base linux linux-firmware nano
	genfstab -U /mnt >> /mnt/etc/fstab
	cd Files
	chmod +600 hostname
	chmod +700 hostname
	chmod +600 hosts
	chmod +700 hosts
	chmod +600 locale.gen
	chmod +700 locale.gen
	cp hostname /mnt/etc/hostname
	cp hosts /mnt/etc/hosts
	cp locale.gen /mnt/etc/locale.gen 
	sleep 5
	mkdir /mnt/Installer
	cd ../
	cp installer-Amdgpu-EFI-Full.sh /mnt/Installer
	cp installer-Intel-EFI-Full.sh /mnt/Installer
	cp installer-Nvidia-EFI-Full.sh /mnt/Installer
	echo "Installer: Installer part2 is installed to /Installer/ for graphics drivers and BIOS or UEFI"
	echo "Installer: use chmod +x on installer of choice"
	arch-chroot /mnt
	
fi
 
