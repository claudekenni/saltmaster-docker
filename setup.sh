#!/bin/bash
set -x

number_masters=$(docker-compose ps | grep master | grep Up | wc -l)

hostaddress="$(hostname -i)"

# Clear old rules
ipvsadm -C


# Create a Firewall Mark 4505
#iptables -t mangle -A PREROUTING -d ${hostaddress} -p tcp -m tcp --syn --dport 4505:4506 -j MARK --set-mark 4505

# Add the Services for both Salt Ports as Firewall Mark
ipvsadm -A -f 4505 -s rr -p 900

# Add the Servers to the Service
for ((i=1;i<=$number_masters;i++)); 
do 
   masters[${i}]="$(docker container inspect -f '{{ .NetworkSettings.Networks.saltdocker_salt_net.IPAddress }}' saltdocker_master_${i})"
   ipvsadm -a -f 4505 -r ${masters[${i}]}:0 -m -w 5 # Docker Salt Masters
done


