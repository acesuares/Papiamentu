#!/bin/bash
WORKDIR=test

cd $WORKDIR
for i in * 
do
 new_name=`echo $i | tr [:upper:] [:lower:] | sed "s/ /_/g" | sed "s/,/_òf_/g" | sed "s/__/_/g"`
 echo "$i" \; "$new_name"
done
