#!/bin/bash

#################################################
# Author: Ayoub Boulila <ayoubboulila@gmail.com>
# script for starting up snap tribe based on 
# ENV variables
# 
# 
################################################

run(){
local mode = $MODE
if [ mode -eq "master" ] 
then
echo "AYB [debug]: starting tribe master node"
snapd --tribe -t $TRUST --api-port $APIPORT --tribe-node-name $HOST

elif [ mode -eq "member" ] 
then
echo "AYB [debug]: starting member node"
snapd --tribe -t $TRUST --tribe-port $TRIBEPORT --tribe-addr $TRIBEADDR --api-port $APIPORT --tribe-node-name $HOST --tribe-seed $SEEDIP:$SEEDPORT

fi
}



case "$1" in
  (run)
    run
    exit 0
    ;;

  (*)
    echo -e "$G Usage: sudo bash $0 {run} $N"
    exit 2
    ;;
esac
