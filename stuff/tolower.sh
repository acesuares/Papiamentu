#!/bin/bash
for i in * 
do
 new_name=`echo $i | tr [:upper:] [:lower:]`
 mv "$i" "$new_name"
done
