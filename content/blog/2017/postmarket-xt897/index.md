Title: Porting PostmarketOS to the Motorola Photon Q
Date: 2017-08-17 02:34:04
Authors: Christian Chapman
Slug: postmarket-xt897
---

[PostmarketOS](https://www.postmarketos.org) has a goal to make old cell phones useful past their shelf life. Right now their efforts are towards getting [Alpine Linux](https://alpinelinux.org) to run on as many phones as possible. The majority their codebase right now is a tool called `pmbootstrap` that automates parts of porting Alpine. Porting is further facilitated by the availability of working kernel sources for tons of different Android phones from LineageOS (CyanogenMod). Since all the hard parts of porting are essentially done for you, I figured it would be an interesting exercise to get Postmarket running on my backup phone, a Motorola Photon Q (xt897). This post is a rough log of all the arcane knowlege it took beyond PostmarketOS's straightforward [porting guide](https://github.com/postmarketOS/pmbootstrap/wiki/Porting-to-a-new-device). 


Getting `pmbootstrap` running
---

I did all my work inside a new Debian 9 virtual machine. 

First I tried to clone [PostmarketOS/pmbootstrap](https://github.com/postmarketOS/pmbootstrap/) through GitHub Desktop for Windows, but the virtual machine gave a ton of errors trying to work on this copy. This was for two reasons: 

* File ownership was all messed up 
* All the files were written in DOS format, so scripts would fail because of spurious `\r`s everywhere. 

From the VM, I cloned the repo again to an external drive and got new errors. This was because the drive was mounted without the `dev` flag, which grants a filesystem the privilege of containing device files. This is important because `pmbootstrap` must create a chroot environments with devices like `/dev/null`. 

Getting a kernel to compile
---

Although an eventual goal of PostmarketOS is to get all its devices running on a mainline Linux kernel, this is impractical for now, so they mostly just take kernels from LineageOS. Some phones in the LineageOS tree have their own dedicated repository and the porting guide seems to have been written with this sort of device in mind. Other devices like my [xt897](https://github.com/LineageOS/android_device_motorola_xt897), are part of a [family of derivatives](https://github.com/LineageOS/android_device_motorola_msm8960_jbbl-common). From the child repo we can see from the `BoardConfigCommon.mk` file that the xt897's kernel source is kept in [/kernel/motorola/msm8960-common](https://github.com/LineageOS/android_kernel_motorola_msm8960-common). `BoardConfigCommon.mk` also reveals the right defconfig to use.

Build failed at this point because some methods in the kernel source (`return_address` and `page_swapcount`) were defined in two places. PostmarketOS uses a much newer gcc toolchain than the one LineageOS uses, and some needed leniencies in gcc's C interpreter have since been removed, creating these errors. Inspecting `BoardConfigCommon.mk` again, [you can see that](https://github.com/LineageOS/android_device_motorola_msm8960_jbbl-common/blob/680cf488ebc5bfbeaaeb19c7ceb77f724f30c8ec/BoardConfigCommon.mk#L41) LineageOS uses gcc 4.8 which is ancient compared to PostmarketOS's gcc 6. To fix this I branched the kernel source, commented out the spurious definitions and included the git-diff in the postmarket build process as a patch. 

At some point in the build process, some script will try to run `lzma -9 [...]`. Alpine Linux's (busybox's) builtin LZMA does not have a -9 option, so the `xz` package (which includes a complete `lzma` tool) must be installed in the build chroot environment.

After this, `pmbootstrap build` would produce image files.


Flashing images to the device
---

The xt897 uses the fastboot protocol to write images. `pmbootstrap` wraps fastboot in its interface, although this does not involve anything more than running a few `fastboot` commands. At this point, an attempt to flash the system image either with pmbootstrap's interface, using Android fastboot directly, or using Motorola's own fastboot implementation would all fail with a mostly uninformative error message: 
    
    (bootloader) Unknown chunk type

A short summary of fastboot's entire protocol and operation which I found to be really demystifying is given [here](http://www.2net.co.uk/tutorial/android-sparse-image-format). Inspection of the .img files' chunk types using `simg_dump.py` (both terms are defined in the previous link) revealed that the produced images were perfectly fine with no strange chunk types. So why won't it flash? It turned out to be a filesystem format problem. PostmarketOS creates the system partition with an ext2 filesystem, whereas my xt897 expects the system partition to be ext4, and the bootloader won't flash unless it's the right partition type. I was surprised it could detect this, since ext2 and ext4 have the same partition IDs, so the bootloader must be doing some level of interpretation of the FS. 

I changed all the parts of pmbootstrap that made ext2 partitions to make ext4 and remade all the images. Now images successfully flash using motorola's fastboot, but boot hangs. The device now hangs at the bootloader screen as if the kernel either crashes very early or just isn't being run at all.  

Getting a kernel to work
---


Getting a userland to work
---

This is where I'm stuck and have to pause my work. My next step is to try the system image with a kernel that is known to work as described here: https://github.com/postmarketOS/pmbootstrap/wiki/Using-prebuilt-kernels . Once I know the postmarket system is working as expected I can go back to trying to get the device to run a kernel we can compile and modify.

To be continued. For now, back to working on things that will help me graduate...
