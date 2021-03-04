#!/bin/sh

ISO_DIR=${HOME}/isos
VMS_DIR=${HOME}/vms

ISO=ubuntu-20.10-desktop-amd64.iso
VM=ubuntu-20.10-desktop.qcow2

# Check for ISO
checkiso() {
    if [ -f "${ISO_DIR}/${ISO}" ]; then
        echo "Found ISO...";
    else
        echo "Could not find ISO...quitting"
        break
    fi
}

# Check for IMG
checkimg() {
    if [ -f "${VMS_DIR}/${VM}" ]; then
        echo "Found VM..."
    else
        echo "Could not fund VM...quitting"
    fi
}

checkiso
checkimg

set -x

# Ensure app entitlements are applied to avoid
# Reference:
#   https://stackoverflow.com/questions/64642062/apple-hypervisor-is-completely-broken-on-macos-big-sur-beta-11-0-1
#   https://www.reddit.com/r/qemu_kvm/comments/kdhmuj/qemu_hvf_support_for_mac_os_x_bug_sur_hv_error/
#   https://developer.apple.com/documentation/hypervisor/1441424-hv_vm_create?language=objc
codesign -s - --entitlements lib/app.entitlements --force /usr/local/bin/qemu-system-x86_64

qemu-system-x86_64 -M accel=hvf \
    -smp 4 \
    -vga virtio \
    --cpu host \
    -hda ${VMS_DIR}/${VM} \
    -m 4G \
    -device usb-tablet \
    -usb

#qemu-system-x86_64 \
#    -machine accel=hvf \
#    -smp 2 \
#    -hda ${VMS_DIR}/${VM} \
#    -cdrom ${ISO_DIR}/${ISO} \
#    -m 4G \
#    -vga virtio \
#    -usb \
#    -device usb-tablet \
#    -display default,show-cursor=on
