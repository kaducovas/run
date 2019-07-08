#!/bin/bash
#echo "$1"
c=100
#((d=c+30))
while [ $c -ge 10 ]
  do
  echo "Ring $c" ; ./teste_tuningJobFiles_l3.sh $c ; sleep 10 ; ./teste_grid3.sh
  sleep 15
  while [ $(ls /scratch/22061a/caducovas/SAE3 | wc -l) -gt 0 ]
    do
    while [ $(qstat -u caducovas | wc -l) -gt 0 ]
      do
        if [ $(qstat -u caducovas | grep H | wc -l) -gt 0 ]
        then
          qselect -u caducovas | xargs qdel -W force ; rm /scratch/22061a/caducovas/run/N1-*
          echo "Ring $c" ; ./teste_tuningJobFiles_l3.sh $c ; sleep 10 ; ./teste_grid3.sh
        else
          qstat -u caducovas ; sleep 5
        fi
      done

    if [ $(ls /scratch/22061a/caducovas/SAE3 | wc -l) -gt 0 ]
      then
      ./teste_grid3.sh
    fi
    done
  ((c=c-10))
  #((d=c+30))
  done

