# Optimized, libvirt-compatible definitions for common OS

## Goal

This repository's goal is to maintain definitions that are tuned for running modern, GUI-driven guest operating systems (OS), easing their installation on hosts that leverage KVM, such as [Phyllome OS](https://phyllo.me/).

[Libvirt](https://libvirt.org/) is the most popular virtualization library on Linux, and it is central to Phyllome OS.

Libvirt uses an XML file to store the definition of a virtual machine, including its firmware (e.g. BIOS or UEFI-based), the size of its memory, the nature of a particular device (e.g. virtio or emulated hardware), etc.

### Why

[The reference Domain XML format webpage](https://libvirt.org/formatdomain.html), which is almost 100 pages long, lists most of the accepted parameters that can be used to define a virtual machine. 

Picking the most optimized parameters for running a particular guest OS is a complicated task. This project intends to find the best parameters for the most popular OS.

The best parameters are defined as parameters that are: 
- Performance-oriented, providing good out-of-the-box performance.
- Relatively host-agnostic, so that a virtual machine could be migrated to another host. 
- Modern, leveraging as many paravirtualized devices (a.k.a virtio devices) the target guest OS can support, with the intend to become usable with modern virtualization solution such as the Cloud Hypervisor. 

There are two kinds of definition for QEMU: **session-driven** virtual machines, and **system-driven** virtual machines. 

- **System-driven virtual machines** are running with higher privileges. If one intend to share a physical device with a virtual machine using VFIO passthrough, this is the definition to use. More information [here](https://blog.wikichoon.com/2016/01/qemusystem-vs-qemusession.html) or [here](https://wiki.libvirt.org/FAQ.html#what-is-the-difference-between-qemu-system-and-qemu-session-which-one-should-i-use)

- **Session-driven virtual machines** are running with user-derived privileges. 

## Usage

### Requirements

It is expected that libvirt and other dependencies such as QEMU or the Cloud Hypervisor are already installed and correctly configured.

* At least `QEMU` emulator version 7.0.0
* At least `libvirt` 8.6.0
* [Netboot.xyz](https://netboot.xyz/) ISO file under `/var/lib/libvirt/isos`

### How to use it

* Create folder to store ISOs under `/var/lib/libvirt/`

```
# mkdir /var/lib/libvirt/isos
```

* Download `Netboot.xyz.iso` file

```
# wget https://boot.netboot.xyz/ipxe/netboot.xyz.iso -P /var/lib/libvirt/isos/
```

* Clone this repository

* Navigate to the *session* directory

* Choose your target OS of choice and, as a normal user, use the following `virsh` command to create a virtual machine using the `define` argument:

```
$ virsh define linux54.xml
Domain 'Linux5.4' defined from linux54.xml
```

* List the newly-created virtual machine

```
$ virsh list --all
 Id   Name       State
------------------------
 -    Linux5.4   shut off
```

* Delete the virtual machine usine the `undefine` argument

```
$ virsh undefine Linux5.4
Domain 'Linux' has been undefined
```

### System-driven virtual machines

* Navigate to the *system* directory

* Choose your target OS of choice and, as a root user, use the following `virsh` command to define a virtual machine:

```
# virsh define linux54.xml
Domain 'Linux5.4' defined from linux54.xml
```

```
# virsh list --all
 Id   Name       State
------------------------
 -    Linux5.4   shut off
```

* Delete it

```
# virsh undefine Linux5.4
Domain 'Linux5.4' has been undefined
```

## Status

|     | Linux 5.4 | Linux 5.15 | Windows 10 | Windows 11 |
| --- | --- | --- | --- | --- |
| *Chipset* | `Q35` | `Q35` | `Q35` | `Q35` |
| *Platform Firmware* | `OVMF` | `OVMF` | `OVMF` | `OVMF` |
| *Secure boot* | No  | No  | No  | **Yes** |
| *[Netboot.xyz](https://netboot.xyz/) ISO loaded* | **Yes** | **Yes** | **Yes** | No |
| *`Spice display`* | **Yes**, with 3D accel. | **Yes**, with 3D accel. | **Yes**, without 3D accel. | **Yes**, without 3D accel. |
| *`virtio-gpu`* | **Yes**, with 3D accel. | **Yes**, with 3D accel. | **Yes**, without 3D  accel. | **Yes**, without 3D  accel. |
| *`virtio-blk`* | Not applicable | Not applicable | Not applicable | Not applicable |
| *`virtio-scsi`* | **Yes** | **Yes** | **Yes** | **Yes** |
| *`virtio-fs`* | **Yes**, for System-driven VM | **Yes**, for System-driven VM | **Yes** | **Yes** |
| *`virtio-net`* | **Yes** | **Yes** | **Yes** | **Yes** |
| *`virtio-keyboard`* | **Yes** | **Yes** | **Yes** | **Yes** |
| *`virtio-tablet`* | **Yes** | **Yes** | **Yes** | **Yes** |
| *`virtio-iommu`* | No | **Yes** | No | No |

More information [here](https://wiki.phyllo.me/e/en/virt/guest) on the status for virtio support on guest operating systems.

## Resources

* Domain XML format for libvirt: https://libvirt.org/formatdomain.html
* qemu:///system vs qemu:///session, a great article by Cole Robinson: https://blog.wikichoon.com/2016/01/qemusystem-vs-qemusession.html