#!/bin/bash
#echo "$1"
c=100

while [ $c -ge 10 ]
do
  echo "Codes $c" ; ./layers1_cae.sh $c ; sleep 10 ; ./teste_grid2.sh
  sleep 15

  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
    do
      qstat -u caducovas ; sleep 5
    done
  ((c=c-10))
done

c=100

while [ $c -ge 10 ]
do
  echo "Codes $c" ; ./layers1.sh $c ; sleep 10 ; ./teste_grid2.sh
  sleep 15

  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
    do
      qstat -u caducovas ; sleep 5
    done
  ((c=c-10))
done

c=100

while [ $c -ge 10 ]
do
  echo "Codes $c" ; ./layers2.sh $c ; sleep 10 ; ./teste_grid2.sh
  sleep 15

  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
    do
      qstat -u caducovas ; sleep 5
    done
  ((c=c-10))
done

c=100

while [ $c -ge 10 ]
do
  echo "Codes $c" ; ./layers3.sh $c ; sleep 10 ; ./teste_grid2.sh
  sleep 15

  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
    do
      qstat -u caducovas ; sleep 5
    done
  ((c=c-10))
done

#c=100

#while [ $c -ge 10 ]
#do
#  echo "Codes $c" ; ./layers4.sh $c ; sleep 10 ; ./teste_grid2.sh
#  sleep 15
#
#  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
#    do
#      qstat -u caducovas ; sleep 5
#    done
#  ((c=c-10))
#done

#c=100

#while [ $c -ge 10 ]
#do
#  echo "Codes $c" ; ./layers5.sh $c ; sleep 10 ; ./teste_grid2.sh
#  sleep 15
#
#  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
#    do
#      qstat -u caducovas ; sleep 5
#    done
#  ((c=c-10))
#done

#c=100

#while [ $c -ge 10 ]
#do
#  echo "Codes $c" ; ./layers8.sh $c ; sleep 10 ; ./teste_grid2.sh
#  sleep 15
#
#  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
#    do
#      qstat -u caducovas ; sleep 5
#    done
#  ((c=c-10))
#done


