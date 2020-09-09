#!/bin/bash

# mntftp - Simple FTP Mount tool for Linux
# Copyright (C) 2020 Dovi Cowan - dovi@fullynetworking.co.uk

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

echo "mntftp -  Simple FTP Mount tool for Linux"
echo
echo "Copyright (C) 2020 Dovi Cowan - dovi@fullynetworking.co.uk"
echo "This program comes with ABSOLUTELY NO WARRANTY; for details see the GNU GPL v3.0."
echo "This is free software, and you are welcome to redistribute it"
echo "under certain conditions; see the GNU GPL v3.0."
echo
echo "FTP MOUNTER v1"
echo
echo "Installation"
echo
echo "Stage 1: Installing curlftpfs"
sudo apt install -y curlftpfs
echo "Stage 2: Setting up your system"
echo -n "Creating mnt folder... "
mkdir ~/mnt
echo "done"
echo -n "Checking if mount.sh is in same directory... "
INSTALL_DIR=""
if test -f "mount.sh"; then
    echo "yes"
    INSTALL_DIR=$(pwd)
    echo -n "Making mount.sh executable... "
    chmod +x mount.sh
    echo "done"
else
    echo "no"
    if test -d "~/.local/share"; then
        echo -n "Creating folder ~/.local/share/mntftp... "
        mkdir ~/.local/share/mntftp
        INSTALL_DIR="~/.local/share/mntftp"
        echo "done"
    else
        echo -n "Creating folder ~/mntftp... "
        INSTALL_DIR="~/mntftp"
        mkdir ~/mntftp
        echo "done"
    fi
    echo -n "Downloading mount.sh... "
    curl -s https://github.com/dcowan-london/mntftp/raw/master/mount.sh --output $INSTALLDIR/mount.sh
    echo "done"
    echo -n "Making mount.sh executable... "
    chmod +x $INSTALL_DIR/mount.sh
    echo "done"
fi
echo -n "Adding .bashrc alias... "
echo "alias mntftp=\"$INSTALL_DIR/mount.sh\"" >> ~/.bashrc
echo "done"
echo -n "Creating mount.txt... "
touch $INSTALL_DIR/mount.txt
echo "done"
echo -e "\e[1mDone installing mntftp. Run \"mntftp help\" to get started.\e[0m"