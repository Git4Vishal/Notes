#!/bin/bash

if [ -z ${1+x} ]; then
 echo "Usage:"
 echo "tunnel.sh start"
 echo "tunnel.sh stop"
 exit
fi
 
if [ $1 = "start" ]; then
 echo "Starting tunnels..."
 sudo ssh -N -R 5000:localhost:5000 10.7.229.5 &
 sudo ssh -N -R 5000:localhost:5000 10.7.229.6 &
 sudo ssh -N -R 5000:localhost:5000 10.7.228.7 &
 sudo ssh -N -R 5000:localhost:5000 10.7.228.6 &
 echo "Done."
elif [ $1 = "stop" ]; then
 echo "Stopping tunnels..."
 for i in `ps ax | grep ssh | grep 5000 | awk '{print $1}'`; do sudo kill -9 $i; done;
 echo "Done."
else 
 echo "Command not recognized"
 echo "Usage:"
 echo "tunnel.sh start"
 echo "tunnel.sh stop"
fi
