## Creating a Vagrant Virtual Development Environment ##

[Vagrant](http://docs.vagrantup.com/v2/why-vagrant/index.html) is open-source software used to create lightweight and portable virtual development environments. Vagrant works like a "wrapper" for VirtualBox that can create, configure, and destroy virtual machines with the use of its own terminal commands. Vagrant facilitates the setup of environments without any direct interaction with VirtualBox and allows developers to use preferred editors and browsers in their native operating system.

###  Install Vagrant ###

- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  - Do not open VirtualBox or create a virtual machine. This will be handled by Vagrant.
- Download and install [Vagrant](http://www.vagrantup.com/downloads.html)
  - Package managers like apt-get and gem install will install an older version of Vagrant so it is required to use the download page.

Create a [fork](https://github.com/pangea/xcore/fork) of `xcore`, a [fork](https://github.com/pangea/xcore-extensions/fork) of `xcore-extensions`, and a [fork](https://github.com/pangea/xcore-vagrant/fork) of `xcore-vagrant` repositories on Github.

Note: This document is for setting up a virtual environment on a Unix host. If you are using a Windows host,
please use [these instructions](https://github.com/lynnaloo/xtuple-vagrant/wiki/Creating-a-Vagrant-Virtual-Environment-on-a-Windows-Host).

Clone the `xcore` and `xcore-extensions` repositories to a directory on your host machine:

    mkdir dev
    cd dev
    git clone --recursive https://github.com/<username>/xcore.git
    git clone --recursive https://github.com/<username>/xcore-extensions.git

Clone the `xcore-vagrant` repository in a separate directory adjacent to your development folder:

    cd ..
    mkdir vagrant
    cd vagrant
    git clone https://github.com/<username>/xcore-vagrant.git
    cd xcore-vagrant

### Setup Vagrant ###

- Edit the `Vagrantfile` and change the `sourceDir` variable to match the location of the cloned xTuple source code: `sourceDir = "../../dev"`
  - This path should be relative to the location of the Vagrantfile

- [Optional] Edit the host machine's `hosts` file (private/etc/root) as root and add an entry for the virtual machine: `192.168.33.10 xcore-vagrant`

### Install VirtualBox Guest Additions Plugin

    vagrant plugin install vagrant-vbguest

### Connect to the Virtual Machine ###

Start the virtual machine:

    vagrant up
    
- Vagrant will automatically run a shell script to install git and the xCore development environment

Connect to the virtual machine via ssh:

    vagrant ssh
    
- The xCore source code is synced to the folder `~/dev`

Start the datasource:

    cd dev/pcore/node-datasource
    npm start 

Launch your local browser and navigate to the static IP Address `http://192.168.33.10:8888` or
the alias that you used in the hosts file `http://xcore-vagrant:8888`

Default username and password to your local application are `admin`

### Additional Information ###

Edit `pg_hba.conf` to allow the host machine to access Postgres (assumes vim is installed):

    sudo vim /etc/postgresql/[postgres version]/main/pg_hba.conf

Add an entry for the IP address of the host machine:

    host    all     all     [host ip]/32   trust

The virtual machine can be shut down by using the command:

    vagrant halt

The virtual machine can be destroyed with this command:

    vagrant destroy
