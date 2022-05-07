# Arch Linux with encrypted BTRFS Installation

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

| dev       | size     | fs     | type                | mount |
|-----------|----------|--------|---------------------|-------|
| /dev/sda1 | 1024 KiB | raw    | [ef02] BIOS boot    |       |
| /dev/sda2 | 512 MiB  | vfat   | [ef00] EFI System   | /boot |
| /dev/sda3 | 4 GiB    | swap   | [8200] Linux Swap   |       |
| /dev/sda4 | <any>    | <none> | [8304] Linux x86-64 | /     |

## Step 5: Create LUKS cryptocontainer

Encrypt `/dev/sda4` partition with password

``` sh
cryptsetup luksFormat /dev/sda4
```

Unlock `/dev/sda4` and create `/dev/mapper/root` device

``` sh
cryptsetup luksOpen /dev/sda4 root
```

## Step 6: Creating Filesystems

Now we must format the partitons with the respective file systems.

We need FAT32 file system for `/boot`:

``` sh
mkfs.vfat /dev/sda2
```

For `/swap` partition, we need to make the partition and activate swap so:

``` sh
mkswap /dev/sda3
swapon /dev/sda3
```

For `/` (root), we need to make with the btrfs file system:

``` sh
mkfs.btrfs /dev/mapper/root
```

## Step 7: Mounting the partitions and subvolumes

Now we must mount the partitions that we just created (except swap as it is not used to store static files).

``` sh
mount /dev/mapper/root /mnt
```

Now that we have mounted the root subvolume, we must create subvolumes for btrfs.

``` sh
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@var
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@.snapshots
umount /mnt
```

Now to mount these partitions:

``` sh
mount -o noatime,compress=zstd:1,subvol=@ /dev/mapper/root /mnt

# You need to manually create folder to mount the other subvolumes at
mkdir /mnt/{boot,home,var,tmp,.snapshots}

mount -o noatime,compress=zstd:1,subvol=@home /dev/mapper/root /mnt/home

mount -o noatime,compress=zstd:1,subvol=@tmp /dev/mapper/root /mnt/tmp

mount -o noatime,compress=zstd:1,subvol=@.snapshots /dev/mapper/root /mnt/.snapshots

mount -o subvol=@var /dev/mapper/root /mnt/var

# Mounting the boot partition at /boot folder
mount /dev/sda2 /mnt/boot
```

Verify that you have mounted everything correctly:

``` sh
lsblk
```

## Step 8: Installing the base system

For VMs:

``` sh
pacstrap /mnt base linux linux-firmware nano btrfs-progs
```

For Intel CPUs:

``` sh
pacstrap /mnt base linux linux-firmware nano btrfs-progs intel-ucode
```

For AMD CPUs:

``` sh
pacstrap /mnt base linux linux-firmware nano btrfs-progs amd-ucode
```

## Step 9: Generate fstab

After installation of all packages is done, we need to now generate the fstab. The fstab file is used to define how disk partitions, various other block devices, or remote filesystems should be mounted into the filesystem. Generate it using:

``` sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Verify fstab entries by:

``` sh
cat /mnt/etc/fstab
```

## Step 10: Encrypt swap

Disable swap

``` sh
swapoff /dev/sda3
```

Create small ext2 filesystem for storing swap LABEL

``` sh
mkfs.ext2 -L cryptswap /dev/sda3 1M
```

Edit `/mnt/etc/crypttab`

``` sh
nano /mnt/etc/crypttab
```

Add line:

``` text
swap LABEL=cryptswap /dev/urandom swap,offset=2048,cipher=aes-xts-plain64,size=512
```

Edit `/mnt/etc/fstab`

``` sh
nano /mnt/etc/fstab
```

Change swap line (UUID of `/dev/sda3` -> `/dev/mapper/swap`)

``` text
/dev/mapper/swap none swap defaults 0 0
```

## Step 11: Chroot into install

Now you must enter your Arch install to set it up:

``` sh
arch-chroot /mnt
```

## Step 12: Setting timezone

You set timezone using:

``` sh
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Now to sync hardware and system clock:

``` sh
hwclock --systohc
```

## Step 13: Setting System Locale

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

## Step 14: Network Configuration

We now need to set our Hostname

``` sh
echo <hostname> >> /etc/hostname
```

Replace `<hostname>` with whatever hostname you wish to set.

Now for the hostfiles:

``` sh
nano /etc/hosts
```

Arch Wiki states the format for this:

``` text
127.0.0.1   localhost
::1         localhost
127.0.0.1   <hostname>.localdomain  <hostname>
```

## Step 15: Setting password for root user

``` sh
passwd
```

Enter your password twice to set root password.

## Step 16: Installing remaining essential packages

``` sh
pacman -S grub grub-btrfs efibootmgr linux-headers networkmanager bluez os-prober dosfstools mtools git curl
```

## Step 17: Adding btrfs module and encrypt hook to mkinitcpio

``` sh
nano /etc/mkinitcpio.conf
```

Add `btrfs` in `MODULES=()`

``` text
# MODULES
# The following modules are loaded before any boot hooks are
# run.  Advanced users may wish to specify all system modules
# in this array.  For instance:
#     MODULES=(piix ide_disk reiserfs)
MODULES=(btrfs)
```

Add `encrypt` before `filesystems` in `HOOKS=(...)`

``` text
HOOKS=(... encrypt filesystems ...)
```

Now to recreate the image:

``` sh
mkinitcpio -p linux
```

Replace `linux` with `linux-lts` if you installed the lts kernel

## Step 18: Installing GRUB

Edit grub config to enable encryption

``` sh
nano /etc/default/grub
```

Add `cryptdevice` and `root` to `GRUB_CMDLINE_LINUX_DEFAULT`. You can find uuid of luks partition via `blkid` (/dev/sda4)

``` text
GRUB_CMDLINE_LINUX_DEFAULT="... cryptdevice=UUID=<uuid-of-luks-partition>:root root=/dev/mapper/root"
```

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

## Step 19: Enabling services

``` sh
systemctl enable NetworkManager
## If you installed bluez
systemctl enable bluetooth
```

## Step 20: Restarting into Arch

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

## Step 21: Installing SARBS

As root, run the following

``` sh
curl -L https://git.io/JDzX9 | sh
```
