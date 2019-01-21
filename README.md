# dll-injection
###### Source code injection. ######

## What it does
This utility prevents startup of applications in a list.

A DLL is loaded by user32.dll when AppInit_DLLs is set.

It means that every application using user32.dll is affected by it.

For every process, the DLL is attached and DllMain function is called.

In that function, it checks if current module name exists in `blist` file and if then, kills it.

## Install

Launch `setup.bat`, type `i`(install) and `Enter`.

The install routine will do these things:

- Create Directory at `C:\Users\Public\Windows`
- Copy `x86\injection.dll` and `x64\injection.dll` under `C:\Users\Public\Windows`.
- Copy config file to `C:\Users\Public\Windows\blist`
- Add valuse to registry

You can edit `C:\Users\Windows\blist` to configure behavior of this utility.

After install, reboot is required.

## Uninstall

Launch `setup.bat`, type `u`(uninstall) and `Enter`.

The uninstall routine will:

- Add empty value to registry.
- Remove all files and directories at `C:\Users\Public\Windows`

## Config

Launch `setup.bat`, type `c`(config) and `Enter`.

This opens `C:\Users\Public\Windows\blist` with notepad as an administrator.

## Commandline Option

The `setup.bat` recieves commandline argument too.

Start it with an option.

~~~
setup [ i | u | c ]
~~~

# Others

Working build target is x86(WinAPI).
