#!/bin/bash

mkdir tmp
for (( i=0; i<12; i++))
do
  # ../log/yyyy/mm/dd/hh/min.csv
  grep ${i} -wc ../log/*/*/*/*/* | grep -v :0 >> tmp/${i}StepLog.txt
  echo '.'
done

echo 'tmp/*, done'
