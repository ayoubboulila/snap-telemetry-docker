#!/bin/bash

#################################################
# Author: Ayoub Boulila <ayoubboulila@gmail.com>
# script for starting up snap tribe based on 
# ENV variables
# 
# 
################################################

run(){

if [ "${MODE}" == "master" ] 
then
echo "AYB [debug]: starting tribe master node"
sudo snapd --tribe -t $TRUST --api-port $APIPORT --tribe-node-name $HOST

elif [ "${MODE}" == "member" ] 
then
echo "AYB [debug]: starting member node"
sudo snapd --tribe -t $TRUST --tribe-port $TRIBEPORT --tribe-addr $TRIBEADDR --api-port $APIPORT --tribe-node-name $HOST --tribe-seed $SEEDIP:$SEEDPORT

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
