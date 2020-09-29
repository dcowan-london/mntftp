# mntftp - Simple FTP Mount tool for Linux
Mount remote FTP folders as local directories

## Usage

### Installation

#### Automatic Installation
Just paste the following line into a terminal to get set up:

`cd; wget https://raw.githubusercontent.com/dcowan-london/mntftp/master/install.sh; chmod +x install.sh; ./install.sh`

You will then need to close and reopen any open terminal windows. You may need to log out and log back in.

#### Manual Installation
You'll need to install `curlftpfs` - on Debian based distros, run:
`$ sudo apt install curlftpfs`.

Download `mount.sh` and save it on your computer, and create a folder `~/mnt` This is where the FTP folders will be mounted.

Make `mount.sh` executable:
`$ chmod +x /path/to/mount.sh`

To create an alias so that you can use it by simply running `$ mntftp [command]`, add `alias mntftp="/path/to/mount.sh"` to your `~/.bashrc`.

### Command line tools
```
$ mount.sh h
mntftp -  Simple FTP Mount tool for Linux

Copyright (C) 2020 Dovi Cowan - dovi@fullynetworking.co.uk
This program comes with ABSOLUTELY NO WARRANTY; for details see the GNU GPL v3.0.
This is free software, and you are welcome to redistribute it
under certain conditions; see the GNU GPL v3.0.

FTP MOUNTER v1

FTP MOUNTER uses curlftpfs to mount FTP drives to a local folder.
FTP MOUNTER reads mount information from mount.txt by default. Use custom_mounts_file to use a custom mounts file, as detailed below.

USAGE:
mntftp [mount|umount|add|remove|edit] mountname (custom_mounts_file)
mntftp list (custom_mounts_file)

FTP MOUNTER v1 by Dovi Cowan - Fully Networking UK - dovi@fullynetworking.co.uk
```

### `mount.txt`
The tool currently looks for a `mount.txt` file in `~/dev/` with the following syntax:
```
ftp_username:ftp_password:ftp_server:mountname
ftp_username:ftp_password:ftp_server:mountname
ftp_username:ftp_password:ftp_server:mountname
...
```

The `mount.txt` file can have as many lines as you wish.

You can add comments by beginning a line with a #.

You can tell the tool to look for `mount.txt` somewhere else with:
```
$ mount.sh command mountname /path/to/mount.txt
```

### Mount location
The tool currently attempts to mount the FTP folder at `~/mnt/mountname`.

### Edit
There is currently a paramater `$ mount.sh edit`. This simply runs `nano /path/to/mount.txt`.

### Unmount
Run `$ mount.sh umount mountname` to unmount.

### Add and Remove
The `help` command currently shows there is a `add` and `remove` command available. These have not yet been implemented.

## Future Development
Current planned additions:

* Allow mounting in custom locations
* Create a config file to allow remembering custom mount locations, custom `mount.txt` locations or anything else in the future.
* Create a proper editor for mounts, using the `add`, `remove` and `edit` commands.
