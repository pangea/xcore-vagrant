#!/bin/sh

# fix for error message from Vagrant, but it may still show up
if `tty -s`; then
   mesg n
fi

# set xcore source directory
XCORE_DIR=/home/vagrant/dev/xcore/

# handy little function from install_script
cdir() {
	echo "Changing directory to $1"
	cd $1
}

# install git
sudo apt-get install git -y -q
echo "Git has been installed!"

# this is temporary fix for the problem where Windows
# cannot translate the symlinks in the repository

# the more permanent solution would loop through the links and edit:
#SYMLINKS = git ls-files -s | awk '/120000/{print $4}'
#for LINK in $SYMLINKS
#then
# update symlinks
#git update-index --assume-unchanged $symlink
#end

# go to xtuple source directory
cdir $XCORE_DIR
git reset --hard

#echo "Changing directory to lib"
#cd /home/vagrant/dev/xcore/lib/
#rm module
#ln -s ../node_modules/ module
#git update-index --assume-unchanged module

#echo "Changing directory to application"
#cd /home/vagrant/dev/xcore/enyo-client/application/
#rm lib
#ln -s ../../lib/ lib
#git update-index --assume-unchanged lib

cdir $XCORE_DIR
echo "Installing development environment"
bash scripts/install.sh

echo "The xCore install development script is done!"
