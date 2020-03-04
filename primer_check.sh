#!/bin/sh

# Quick and dirty script to see which of these unmerged Hewavitharana seqs 
# DO NOT have the reverse primer pattern listed in the article

PATTERN='GGACTAC[A,C,T,U][A,C,G]GGGT[A,T,U]TCTAAT'

for i in *.fastq; do
	EXISTS=$(grep -Eo $PATTERN $i)
	if [ ! -n "$EXISTS" ]; then
		echo "No reverse primer in $i"
	elif [ -n "$EXISTS" ]; then
		echo "Reverse primer found in $i"
	fi
done
