#!/bin/bash

#queuedTasks=$(psql -h 201.17.19.173 -p 80 -d ringerdb -U ringer -c "select count(*) from tasks where status = 'queued';" | grep row | cut -d " " -f 1 | cut -d "(" -f 2)
queuedTasks=$(expr $(psql -h 201.17.19.173 -p 80 -d ringerdb -U ringer -c "select count(*) from tasks where status = 'queued' and context = 'official';"  | sed -n 3p ))
maxtasks=5
#queuedTasks=11

if [ $queuedTasks -gt 0 ]
 then
 expr $queuedTasks
 avail=$(expr $maxtasks - $(docker ps | grep saphyra:2.2 | wc -l))
 echo $avail
 if [ $avail -gt 0 ]
  then
  jobs=$(( $avail < $queuedTasks ? $avail : $queuedTasks ))
  echo $jobs
  #mpirun -n $jobs echo 'olar'
  mpirun -n $jobs docker run -v /home/caducovas/Development/volume:/volume -e HOST=$(uname -a | cut -d " " -f 2) -d --rm caducovas/saphyra:2.2
 fi
fi
