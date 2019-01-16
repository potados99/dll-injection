# dll-injection
###### Invisible fear. ######

## What it does
This utility prevents startup of applications in a list.

A DLL is loaded by user32.dll when AppInit_DLLs is set.

It means that every application using user32.dll is affected by it.

For every process, the DLL is attached and DllMain function is called.

In that function, it checks if current module name exists in blist file and if then, kills it.

## Install

When you launch `install` which points `setup.batch` with "install" argument, 

the script will do these things:

- Add valuse to registry 
- Create Directory at `C:\Users\Windows`
- Create config file at `C:\Users\Windows\blist`

You can edit `C:\Users\Windows\blist` to configure behavior of this utility.

After install, reboot is required.

## Uninstall

Launch `uninstall`.
Uninstall does opposite things the installer do, in a reversed order.

## Config

This opens `C:\Users\Windows\blist` with notepad as an administrator.
