# Run Salt Masters in Docker Containers 

This is a PoC of how to run several Salt Masters in Docker Containers.

iptables is used to setup fwmarks for every connection coming in for port 4505 and 4506. This fwmark is then used by IPVS to take the incoming connections and make sure that both minion ports connect to the same Master.

![salt-master-docker](https://user-images.githubusercontent.com/14880565/129295233-c5afadb8-363e-45a5-82c4-98a60d05a22f.png)
