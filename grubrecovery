# Arch Linux Dual Boot Recovery Notes (UEFI)

This document is split into two parts:

1. GRUB Restoration
2. Boot Behavior (Windows vs Arch default)

Based on system:

* Arch root: `/dev/nvme0n1p5`
* EFI System Partition: `/dev/nvme0n1p4`

---

# 1. GRUB Restoration Guide

## Purpose

Fix broken GRUB after Windows update or boot failure.

---

## Step 1 — Boot Live USB

Use Arch ISO and enter terminal.

---

## Step 2 — Identify partitions

```bash
lsblk -f
```

Confirm:

* p5 = Linux root (ext4/btrfs)
* p4 = EFI (vfat/fat32)

````

---

## Step 3 — Mount system
```bash
mount /dev/nvme0n1p5 /mnt
mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p4 /mnt/boot/efi
````

---

## Step 4 — Verify mount

```bash
ls /mnt/boot/efi
```

Expected:

```
EFI
```

---

## Step 5 — Enter system

```bash
arch-chroot /mnt
```

---

## Step 6 — Reinstall GRUB

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
```

---

## Step 7 — Generate config

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

---

## Step 8 — Reboot

```bash
exit
reboot
```

---

# 2. Boot Behavior Configuration (Windows vs Arch)

## Purpose

Control default OS and boot timing in GRUB.

---

## View boot entries

```bash
grep menuentry /boot/grub/grub.cfg
```

Find Windows entry ID like:

```
osprober-efi-9C05-F110
```

---

## Edit GRUB config

```bash
sudo nano /etc/default/grub
```

---

## Recommended stable config

```txt
GRUB_DEFAULT="osprober-efi-9C05-F110"
GRUB_TIMEOUT=3
GRUB_TIMEOUT_STYLE=menu
```

---

## Apply changes

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

# Alternative (safer long-term)

Use saved default system:

```txt
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_TIMEOUT=3
```

Then set Windows once:

```bash
sudo grub-set-default "Windows Boot Manager"
```

---

# Boot order (UEFI level)

Check:

```bash
efibootmgr
```

Set priority (example):

```bash
efibootmgr -o 0001,0005
```

---

# Common issues

* GRUB boots Arch instead of Windows → wrong GRUB_DEFAULT match
* Windows ignores GRUB → UEFI BootOrder prioritizing Arch
* "failed to get canonical" → wrong EFI mount path
* rescue mode → missing or incorrect grub-install

---

# Summary

* GRUB repair = reinstall + regenerate config
* Boot behavior = GRUB_DEFAULT + UEFI BootOrder
* Windows updates often only change BootOrder, not Linux install
