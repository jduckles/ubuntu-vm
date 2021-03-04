# Ubuntu VM using QEMU

This repo details methods for running an Ubuntu VM (or any linux VM really) on Mac OS using just 
the open source qemu and the built-in hvf hypervisor available on recent Mac OS systems. This eliminates
a need for VirtualBox. This mostly exists to remind me how to do this when I forget 🤣. 

One interesting error mode is with the security settings in MacOS, you need to explicitly give the qemu emulator binary application entitlements or it won't run. This is done in the start script using the `app.entitlements` file in `lib`. If you don't do this you'll see an obscure error about the HyperVisor interface not working right. 


## Requirements 
```
brew intall qemu
```


