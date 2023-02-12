---
title: Vms On Linux
categories:
  - linux
date: 2023-02-12
layout: "post"
slug: "vms-on-linux"
menu:
  main:
    weight: -10
---

# Running VMS on Linux

By the end of this tutorial you will have working virtual machines using KVM on Linux

## Check if virtualization is enabled

Run this command:

```sh
egrep -c '(vmx|svm)' /proc/cpuinfo
```

If the output is greater than `0`, then you are good to go  
Otherwise go into BIOS and enable virtualization

## Installation

### Install QEMU and Virtual Machine Manager

- On Debian

```sh
sudo apt install qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y
```

- On Arch

```sh
sudo pacman -S python3 bridge-utils virt-manager
```

### Enable services

```sh
sudo systemctl enable --now libvirtd.service
```

## Start default network

```sh
sudo virsh net-start default
sudo virsh net-autostart default
sudo virsh net-list --all
```

## Add yourself to libvirt

```sh
sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER
```

## Reboot

```sh
sudo reboot
```
