#!/usr/bin/env bash
# Objetivo: Configurar um laboratório LXD vm rapidamente, criando VMs. Este script:
# a) Anexar ponte à vm
# b) Atribua um endereço IPv4
# c) Iniciar VM
# d) Marque VM como inicialização automática na reinicialização do host
# Author: Palamar (https://bloglinux.palamarsolutionit.com.br/)
# License: GPL v2.x+
# Note: Apenas testado e usado no servidor Ubuntu Linux 16.04 / 18.4 LTS
# e servidor Fedora 31.
# Last updated: Nov 14 2019
# -------------------------------------------------------------------- 
### set me first ##
_debug="" # either echo or ""
_lxc="lxc"
vm_arch='amd64'
vm_bridge='lxdbr0'  # Your bridge interface
vm_net_if='eth0'    # VM interface 
vm_start_ip='10.52.230' # Vm subnet 10.114.13.xx/24
vm_first_ip=3           # First vm IP address 10.114.13.3 and so on 
## Customize this ##
## Format:
## vm_os/vm_version/vm_arch|vm-name 
## Following will install and config VM
# CentOS 6/7/8
# Arch Linux
# Gentoo
# Debian 8/9/10
# Fedora 27
# OpenSuse 43.2
# Alpine Linux 3.7
# Sabayon 
# Oracle 7
# Plamo 6
# Ubuntu 18.4 LTS
vm_names="centos/8/${vm_arch}|centos-8 centos/7/${vm_arch}|centos-7 centos/6/amd64|centos-6 archlinux/${vm_arch}|arch gentoo/${vm_arch}|gentoo debian/jessie/${vm_arch}|debian-8-jessie debian/stretch/${vm_arch}|debian-9-stretch debian/10/${vm_arch}|debian-10-buster fedora/31/${vm_arch}|fedora-31 opensuse/15.1/${vm_arch}|opensuse-15-1  alpine/3.10/${vm_arch}|alpine sabayon/${vm_arch}|sabayon oracle/7/${vm_arch}|oracle-7 plamo/6.x/${vm_arch}|plamo ubuntu/bionic/amd64|ubuntu-18-4"

echo "Setting up LXD based VM lab...Please wait..."
for v in $vm_names
do
        # Get vm_os and vm_name
        IFS='|'
        set -- $v
        echo "* Creating ${2%%-*} vm...."
        # failsafe   
	$_debug $_lxc info "$2" &>/dev/null && continue
        # Create vm
        $_debug $_lxc init "images:${1}" "$2"
        # Config networking for vm
        $_debug $_lxc network attach "$vm_bridge" "$2" "$vm_net_if"
        $_debug $_lxc config device set "$2" "$vm_net_if" ipv4.address "${vm_start_ip}.${vm_first_ip}"
        # Start vm
        $_debug $_lxc start "$2"
        $_debug $_lxc config set "$2" boot.autostart true
        # Increase an IP address counter 
        (( vm_first_ip++ ))
done
echo "-------------------------------------------"
echo '* VM Summary'
echo "-------------------------------------------"
$_lxc list