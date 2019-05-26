#!/bin/sh
VBoxManage natnetwork add --netname internal --network "192.168.1.0/24" --dhcp off --enable
VBoxManage hostonlyif create

VBoxManage import IEC_Simulator_Win10.ova --vsys 0 --vmname TFM_win10_client
VBoxManage modifyvm "TFM_win10_client" --cpus 1 --memory 512 --vram 32 --nic1 natnetwork --nat-network1 "internal"

VBoxManage import IEC_Simulator_Win10.ova --vsys 0 --vmname TFM_win10_server
VBoxManage modifyvm "TFM_win10_server" --cpus 1 --memory 512 --vram 32 --nic1 natnetwork --nat-network1 "internal"

#VBoxManage import kali.ova --vsys 0 --vmname TFM_kali
#VBoxManage modifyvm "TFM_kali" --cpus 1 --memory 1024 --vram 32 --nic1 natnetwork --nat-network1 "internal"


