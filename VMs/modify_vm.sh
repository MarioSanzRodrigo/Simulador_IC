#!/bin/sh

interface=$(docker network ls |  grep TFM_3 | awk '{print $1}')
docker_interface=$(echo br-$interface)

VBoxManage modifyvm "TFM_win10_client" --cpus 1 --memory 512 --vram 32 --nic1 bridged --nictype1 82545EM --bridgeadapter1 $docker_interface
VBoxManage modifyvm "TFM_win10_client" --biossystemtimeoffset -10368000000

VBoxManage modifyvm "TFM_win10_server" --cpus 1 --memory 512 --vram 32 --nic1 bridged --nictype1 82545EM --bridgeadapter1 $docker_interface
VBoxManage modifyvm "TFM_win10_server" --biossystemtimeoffset -10368000000

#VBoxManage modifyvm "TFM_kali" --cpus 1 --memory 512 --vram 32 --nic1 bridged --nictype1 82545EM --bridgeadapter1 $docker_interface
