# Arch Linux with BTRFS Installation

[Source](https://www.nishantnadkarni.tech/posts/arch_installation/)

## Step 1: Download Arch Linux and Prepare Installation Medium

Download the latest Arch Linux ISO from [archlinux.org](https://archlinux.org/download/)

## Step 2: Checking internet connection

``` sh
ping google.com
```

## Step 3: Set time

```sh
timedatectl set-ntp true
```

## Step 4: Partitioning your drive

Use `fdisk` or `cfdisk` to partition your drive

For installing Arch with btrfs, we need to make 2 minimum partitions

``` text
/boot/efi partition (512MB size)
/(root) partition
```

You also might want to create `/swap` partition

If you use only one drive I suggest this layout (GUID Partition Table):

|       dev|     size|    fs|         type| mount
|----------|---------|------|-------------|------
| /dev/sda1| 1024 KiB|   raw|    BIOS boot|
| /dev/sda2|  512 MiB|  vfat|   EFI System| /boot
| /dev/sda3|    4 GiB|  swap|   Linux Swap|
| /dev/sda4|    <any>| btrfs| Linux x86-64| /

## Step 5: Creating Filesystems

Now we must format the partitons with the respective file systems.

We need FAT32 file system for `/boot`:

``` sh
mkfs.vfat /dev/sda2
```

For /swap partition, we need to make the partition and activate swap so:

``` sh
mkswap /dev/sda3
swapon /dev/sda3
```

For /(root), we need to make with the btrfs file system:

``` sh
mkfs.btrfs /dev/sda4
```

## Step 6: Mounting the partitions and subvolumes

Now we must mount the partitions that we just created (except swap as it is not used to store static files).

``` sh
mount /dev/sda4 /mnt
```

Now that we have mounted the root subvolume, we must create subvolumes for btrfs.

``` sh
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@var
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@.snapshots
umount /mnt
```

Now to mount these partitions:

``` sh
mount -o noatime,compress=zstd:1,subvol=@ /dev/sda4 /mnt

# You need to manually create folder to mount the other subvolumes at
mkdir /mnt/{boot,home,var,opt,tmp,.snapshots}

mount -o noatime,compress=zstd:1,subvol=@home /dev/sda4 /mnt/home

mount -o noatime,compress=zstd:1,subvol=@opt /dev/sda4 /mnt/opt

mount -o noatime,compress=zstd:1,subvol=@tmp /dev/sda4 /mnt/tmp

mount -o noatime,compress=zstd:1,subvol=@.snapshots /dev/sda4 /mnt/.snapshots

mount -o subvol=@var /dev/sda4 /mnt/var

# Mounting the boot partition at /boot folder
mount /dev/sda2 /mnt/boot
```

Verify that you have mounted everything correctly:

``` sh
lsblk
```

The mountpoints show the last subvolume that you mounted.

## Step 7: Installing the base system

For intel CPUs:

``` sh
pacstrap /mnt base linux linux-firmware nano intel-ucode btrfs-progs
```

For AMD CPUs:

``` sh
pacstrap /mnt base linux linux-firmware nano amd-ucode btrfs-progs
```

For VMs:

``` sh
pacstrap /mnt base linux linux-firmware nano btrfs-progs
```

## Step 8: Generate fstab

After installation of all packages is done, we need to now generate the fstab. The fstab file is used to define how disk partitions, various other block devices, or remote filesystems should be mounted into the filesystem. Generate it using:

``` sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Verify fstab entries by:

``` sh
cat /mnt/etc/fstab
```

## Step 9: Chroot into install

Now you must enter your Arch install to set it up:

``` sh
arch-chroot /mnt
```

## Step 10: Seting timezone

You set timezone using:

``` sh
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Now to sync hardware and system clock:

``` sh
hwclock --systohc
```

## Step 11: Setting System Locale

You need to manually edit a file for this:

``` sh
nano /etc/locale.gen
```

You need to scroll down and uncomment the language you want.

Now generate locales:

``` sh
locale-gen
```

Now we set locale in locale.conf file:

``` sh
locale >> /etc/locale.conf
```

## Step 12: Network Configuration

We now need to set our Hostname

``` sh
echo myhostname >> /etc/hostname
```

Replace `myhostname` with whatever hostname you wish to set.

Now for the hostfiles:

``` sh
nano /etc/hosts
```

Arch Wiki states the format for this:

``` text
127.0.0.1   localhost
::1         localhost
127.0.1.1   myhostname.localdomain  myhostname
```

## Step 13: Setting password for root user

``` sh
passwd
```

Enter your password twice to set root password.

## Step 14: Installing remaining essential packages

``` sh
pacman -S grub grub-btrfs efibootmgr base-devel linux-headers networkmanager  wpa_supplicant dialog os-prober mtools dosfstools reflector git curl
```

## Step 15: Adding btrfs module to mkinitcpio

``` sh
nano /etc/mkinitcpio.conf
```

Add btrfs in `MODULES=()`

``` text
# MODULES
# The following modules are loaded before any boot hooks are
# run.  Advanced users may wish to specify all system modules
# in this array.  For instance:
#     MODULES=(piix ide_disk reiserfs)
MODULES=(btrfs)
```

Now to recreate the image:

``` sh
mkinitcpio -p linux
```

Replace `linux` with `linux-lts` if you installed the lts kernel

## Step 16: Installing GRUB

Installing grub:

``` sh
# For UEFI
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch

# For Legacy BIOS
grub-install /dev/sda
```

Now to generate the configuration file:

``` sh
grub-mkconfig -o /boot/grub/grub.cfg
```

## Step 17: Enabling services

``` sh
systemctl enable NetworkManager
## If you installed bluez
systemctl enable bluetooth
## If you installed cups
systemctl enable org.cups.cupsd
```

## Step 18: Restarting into Arch

``` sh
## Exiting the installation
exit
## Unmounting all drives
umount -l /mnt
## If you're installing Arch on VM
shutdown now
## If you're dual booting/installing on a device
reboot
```

## Step 19: Installing SARBS

As root, run the following

``` sh
curl -L https://git.io/JDzX9 | sh
```
