#!/bin/bash
# srr_munch.sh
#
# Short script to loop through SRRs in an SRA list, running fastq-dump, and
# 	nicely formatting them with bbtools' reformat.sh (for now, with manual
#	read number relabeling).
# usage: srr_munch.sh <sra_list.txt>

# Old snippet to run on default output file from NCBI (SRR_Acc_List.txt)
shopt -s nullglob
#if [[ ! -z $(ls | grep "SRR_Acc_List.*txt") ]]; then
#		while read seq; do
#			fastq-dump --split-3 --gzip $seq
#			echo "dump: $seq"
#		done < $(ls | grep "SRR_Acc_List.*txt")
#fi

while read x; do
	fastq-dump --split-3 --gzip $x
	for i in *.fastq.gz; do
		gzip -d $i
		done		
done < $(ls | grep "SRR_Acc_List.*\.txt")
