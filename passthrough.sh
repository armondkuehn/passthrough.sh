#!/usr/bin/bash
#removes vfs from p1p1
echo "Removing virtual functions from p1p1"
echo 0 > /sys/devices/pci0000\:5d/0000\:5d\:00.0/0000\:5e\:00.0/sriov_numvfs &
sleep 3s
#removes all VFs from interface p1p2
echo "Removing virtual functions from p1p2"
echo 0 > /sys/devices/pci0000\:5d/0000\:5d\:00.0/0000\:5e\:00.1/sriov_numvfs &
sleep 3s
#adds 8 vfs to p1p2
echo 8 > /sys/devices/pci0000\:5d/0000\:5d\:00.0/0000\:5e\:00.1/sriov_numvfs
sleep 3s
#get couchpotato container id
echo "Get Couchpotato container id"
cid=$(docker ps | grep couchpotato | awk '{print $1}')
echo $cid
#pipe couchpotato
echo "Piping couchpotato"
pipework --direct-phys p1p2_6 -l ens4 $cid 192.168.1.6/24@192.168.1.1
docker exec -ti $cid cat /proc/net/dev
#get plex container id
echo "Get Plex container id"
cid=$(docker ps | grep -i plex | awk '{print $1}')
#pipe Plex
echo "Piping Plex"
pipework --direct-phys p1p2_7 -l ens4 $cid 192.168.1.5/24@192.168.1.1
docker exec -ti $cid cat /proc/net/dev
#get sonarr container id
echo "Get sonarr container id"
cid=$(docker ps | grep -i sonarr | awk '{print $1}')
##pipe sonarr
echo "Piping Sonarr"
pipework --direct-phys p1p2_5 -l ens4 $cid 192.168.1.7/24@192.168.1.1
docker exec -ti $cid cat /proc/net/dev
#get sabnzbd container id
echo "Get Sabnzbd container id"
cid=$(docker ps | grep -i sabnzbd | awk '{print $1}')
#pipe sabnzbd
echo "Piping Sonarr"
pipework --direct-phys p1p2_4 -l ens4 $cid 192.168.1.8/24@192.168.1.1
docker exec -ti $cid cat /proc/net/dev
#get transmission container id
echo "Get Transmission container id"
cid=$(docker ps | grep -i transmission | awk '{print $1}')
#pipe transmission
echo "Piping transmission"
pipework --direct-phys p1p2_3 -l ens4 $cid 192.168.1.9/24@192.168.1.1
docker exec -ti $cid cat /proc/net/dev
#exit
echo "All plumbed"

