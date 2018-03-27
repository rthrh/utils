#spotify keys
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt upgrade
sudo apt install gedit chromium-browser
sudo apt install curl git wireshark spotify-client

sudo apt install build-essential

#audio and bluetooth
sudo apt-get install pavucontrol
sudo apt install pulseaudio-module-bluetooth
pactl load-module module-bluetooth-discover

#touchpad off
synclient TouchpadOff=1

#virtualization tools
sudo apt install qemu qemu-kvm libvirt-bin

#install dpdk
sudo apt install libnuma-dev

cd /usr/src/
sudo wget http://fast.dpdk.org/rel/dpdk-17.11.tar.xz
sudo tar xf dpdk-17.11.tar.xz
export DPDK_DIR=/usr/src/dpdk-17.11
cd $DPDK_DIR

export DPDK_TARGET=x86_64-native-linuxapp-gcc
export DPDK_BUILD=$DPDK_DIR/$DPDK_TARGET
sudo make install T=$DPDK_TARGET DESTDIR=install

#install openvswitch
sudo apt install openvswitch-switch openvswitch-common openvswitch-switch-dpdk

#openvswitch with KVM
sudo apt install uml-utilities
sudo ovs-vsctl add-br br0 #add bridge br0
sudo ovs-vsctl add-port br0 eth0

