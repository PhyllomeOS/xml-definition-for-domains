# Libvirt-friendly definitions for common operating systems

Libvirt, the most common virtualization library on Linux, uses XML to store the definition of a virtual machine.

[The reference Domain XML format webpage](https://libvirt.org/formatdomain.html), which lists most of the accepted parameters that can be used to define a virtual machine, is almost 100 pages long. It is daunting to pick the most optimized parameters for running a particular guest operating system (OS) well.

This repository's goal is to maintain definitions that are tuned for running modern OS, leveraging as many paravirtualized devices (virtio) the target guest OS support. 

More information [here](https://wiki.phyllo.me/e/en/virt/guest) on the status for virtio support on guest operating systems.

## Requirements

It is expected that libvirt and other dependencies such as QEMU are already installed and that such tools are already correctly configured.

* At least QEMU emulator version 7.0.0
* At least libvirt 8.6.0

## How to use it

* Clone this repository locally

### Session-driven virtual machines

* Navigate to the session directory
* Choose your target OS of choice and, as a normal user, use the following `virsh` command to define a virtual machine:

```
$ virsh define linux.xml 
```

### System-driven virtual machines

* Navigate to the system directory
* Choose your target OS of choice and, as a root user, use the following `virsh` command to define a virtual machine:

```
# virsh define linux.xml
```

## Status

|                     |             Linux             |       Windows       |
| :------------------ | :---------------------------: | :-----------------: |
| *Chipset*           |             `Q35`             |        `Q35`        |
| *Platform Firmware* |            `OVMF`             |       `OVMF`        |
| *`Spice display`*   |       **Yes**, with 3D        | **Yes**, without 3D |
| *`virtio-gpu`*      |       **Yes**, with 3D        | **Yes**, without 3D |
| *`virtio-blk`*      |        Not applicable         |   Not applicable    |
| *`virtio-scsi`*     |            **Yes**            |       **Yes**       |
| *`virtio-fs`*       | **Yes**, for System-driven VM |       **Yes**       |
| *`virtio-net`*      |            **Yes**            |       **Yes**       |
| *`virtio-keyboard`* |            **Yes**            |       **Yes**       |
| *`virtio-tablet`*   |            **Yes**            |       **Yes**       |


## Ressources

* Domain XML format for libvirt: https://libvirt.org/formatdomain.html
* qemu:///system vs qemu:///session, a great article by Cole Robinson: https://blog.wikichoon.com/2016/01/qemusystem-vs-qemusession.html