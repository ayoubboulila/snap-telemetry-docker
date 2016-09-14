#!/bin/bash

#################################################
# Author: Ayoub Boulila <ayoubboulila@gmail.com>
# script for starting up snap tribe based on 
# ENV variables
# 
# 
################################################

run(){
bash /opt/snap/bin/snapd --tribe -t $TRUST --tribe-port $TRIBEPORT --api-port $APIPORT --tribe-node-name $HOST --tribe-seed $SEEDIP:$SEEDPORT



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