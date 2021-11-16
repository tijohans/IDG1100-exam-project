#!/bin/bash

#sudo apt install lm-sensors
#date +"%T";

temp(){
    
    date +"%T";

    for i in $(seq 1000)
    do
        sensors | grep +;
        #sed s/temp1://;    
        sleep 5;
    done
    
}

temp;


