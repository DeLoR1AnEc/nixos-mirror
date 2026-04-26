# Install Process
## Building from source and flashing
1. `sudo just build`
2. Find your usb drive with `lsblk`
3. `sudo just flash '<you usb drive>'`

## On the end machine
1. `nu /etc/install`
2. Go trough the installer
3. After it's done, reboot into linux and login
4. `cd /config`
5. `sudo just unlock`
6. `sudo just ssh`
7. You're done!

# TODO
[x] Add todos lmao