#!/bin/bash
#echo "$1"

### PCA

# c=100
# #((d=c+30))
# while [ $c -ge 10 ]
#   do
#   echo "Ring $c" ; ./teste_tuningJobFiles_l3.sh $c ; sleep 10 ; ./teste_grid3.sh
#   sleep 15
#   while [ $(ls /scratch/22061a/caducovas/SAE3 | wc -l) -gt 0 ]
#     do
#     while [ $(qstat -u caducovas | wc -l) -gt 0 ]
#       do
#         if [ $(qstat -u caducovas | grep H | wc -l) -gt 0 ]
#         then
#           qselect -u caducovas | xargs qdel -W force ; rm /scratch/22061a/caducovas/run/N1-*
#           echo "Ring $c" ; ./teste_tuningJobFiles_l3.sh $c ; sleep 10 ; ./teste_grid3.sh
#         else
#           qstat -u caducovas ; sleep 5
#         fi
#       done
#
#     if [ $(ls /scratch/22061a/caducovas/SAE3 | wc -l) -gt 0 ]
#       then
#       ./teste_grid3.sh
#     fi
#     done
#   ((c=c-10))
#   #((d=c+30))
#   done
#
#
#
# ### NL PCA
#   c=80
#   ((d=c+30))
#   while [ $c -ge 10 ]
#     do
#     echo "Ring $c" ; ./nlpca_tuningJob.sh $c $d ; sleep 10 ; ./teste_grid3.sh
#     sleep 15
#     while [ $(ls /scratch/22061a/caducovas/SAE3 | wc -l) -gt 0 ]
#       do
#       while [ $(qstat -u caducovas | wc -l) -gt 0 ]
#         do
#           if [ $(qstat -u caducovas | grep H | wc -l) -gt 0 ]
#           then
#             qselect -u caducovas | xargs qdel -W force ; rm /scratch/22061a/caducovas/run/N1-*
#             echo "Ring $c" ; ./nlpca_tuningJob.sh $c $d ; sleep 10 ; ./teste_grid3.sh
#           else
#             qstat -u caducovas ; sleep 5
#           fi
#         done
#       if [ $(ls /scratch/22061a/caducovas/SAE3 | wc -l) -gt 0 ]
#         then
#         ./teste_grid3.sh
#       fi
#       done
#     ((c=c-10))
#     ((d=c+30))
#   done

!/bin/bash
echo "$1"
 c=0
 while [ $c -le 30 ]
   do
   echo "Codes $c" ; ./discAE.sh $c ; sleep 10 ; ./teste.sh
   sleep 15
   ((c=c+1))
 done

  #!/bin/bash
  #echo "$1"
#  c=1
#  while [ $c -le 30 ]
#    do
#    echo "Codes $c" ; ./contractiveAE.sh $c ; sleep 10 ; ./teste.sh
#    sleep 15
#    ((c=c+1))
#  done

#  c=1
#  while [ $c -le 30 ]
#    do
#    echo "Codes $c" ; ./ae.sh $c ; sleep 10 ; ./teste.sh

#    ((c=c+1))
#  done

  # c=1
  # ((d=c+21))
  # ((e=d+30))
  # while [ $c -le 30 ]
  #   do
  #   echo "Codes $c" ; ./sae3_layers.sh $e $d $c ; sleep 10 ; ./teste.sh
  #   ((c=c+1))
  #   ((d=c+21))
  #   ((e=d+30))
  # done
  #
  # c=1
  # ((d=c+31))
  #
  # while [ $c -le 30 ]
  #   do
  #   echo "Codes $c" ; ./sae2_layers.sh $d $c; sleep 10 ; ./teste.sh
  #   ((c=c+1))
  #   ((d=c+31))
  # done

  # c=100
  #
  # while [ $c -ge 10 ]
  # do
  #   echo "Codes $c" ; ./layers1.sh $c ; sleep 10 ; ./teste_grid2.sh
  #   sleep 15
  #
  #   while [ $(qstat -u caducovas | wc -l) -gt 0 ]
  #     do
  #       qstat -u caducovas ; sleep 5
  #     done
  #   ((c=c-10))
  # done
  #
  # c=100
  #
  # while [ $c -ge 10 ]
  # do
  #   echo "Codes $c" ; ./layers2.sh $c ; sleep 10 ; ./teste_grid2.sh
  #   sleep 15
  #
  #   while [ $(qstat -u caducovas | wc -l) -gt 0 ]
  #     do
  #       qstat -u caducovas ; sleep 5
  #     done
  #   ((c=c-10))
  # done
  #
  # c=100
  #
  # while [ $c -ge 10 ]
  # do
  #   echo "Codes $c" ; ./layers3.sh $c ; sleep 10 ; ./teste_grid2.sh
  #   sleep 15
  #
  #   while [ $(qstat -u caducovas | wc -l) -gt 0 ]
  #     do
  #       qstat -u caducovas ; sleep 5
  #     done
  #   ((c=c-10))
  # done
  #
  # #c=100
  #
  # #while [ $c -ge 10 ]
  # #do
  # #  echo "Codes $c" ; ./layers4.sh $c ; sleep 10 ; ./teste_grid2.sh
  # #  sleep 15
  # #
  # #  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
  # #    do
  # #      qstat -u caducovas ; sleep 5
  # #    done
  # #  ((c=c-10))
  # #done
  #
  # #c=100
  #
  # #while [ $c -ge 10 ]
  # #do
  # #  echo "Codes $c" ; ./layers5.sh $c ; sleep 10 ; ./teste_grid2.sh
  # #  sleep 15
  # #
  # #  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
  # #    do
  # #      qstat -u caducovas ; sleep 5
  # #    done
  # #  ((c=c-10))
  # #done
  #
  # #c=100
  #
  # #while [ $c -ge 10 ]
  # #do
  # #  echo "Codes $c" ; ./layers8.sh $c ; sleep 10 ; ./teste_grid2.sh
  # #  sleep 15
  # #
  # #  while [ $(qstat -u caducovas | wc -l) -gt 0 ]
  # #    do
  # #      qstat -u caducovas ; sleep 5
  # #    done
  # #  ((c=c-10))
  # #done
