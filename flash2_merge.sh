#!/bin/bash
# flash2_merge.sh
# DESCRIPTION: A simple script that runs flash2 to merge all fastqs in the current
# 	directory.

# Deps: flash2
# NOTE: RUN AFTER: --- srr_munch.sh
#	RUN BEFORE: -- q2a_reformat.sh

shopt -s nullglob

for i in *1.fastq; do			# Merge all _1 & _2 fastqs
	if [ -f *_1.fastq ]; then
		SUF_REGX="s/_1\.fastq/_2.fastq/"
	elif [ -f *_R1.fastq ]; then
		SUF_REGX="s/_R1\.fastq/_R2.fastq/"
	elif [ -f *_R1.fastq ] && [ -f *_1.fastq ]; then
		echo "Problems!"
		exit 1
	else
		exit 0
	fi	
	REV=$(basename "$i" | sed $SUF_REGX) 
	OUT_FILE=$(basename "$i" | sed -e 's/_\(\|R\)1\.fastq/.merged/')
	echo "Merging: $i" "$REV"
	./flash2 "$i" "$REV" 2>&1	\
		-o $OUT_FILE \
		| tee -a flash.log
	done

shopt -u nullglob
