#!/bin/sh

# q2a_reformat.sh

# DESCRIPTION: Reformats all fastq files in current directory to fasta

# Deps: bbtools 'reformat' tool

# NOTE: RUN AFTER: --- flash2_merge.sh
#	RUN BEFORE: -- groupFormatter.sh

for i in *.fastq; do
	reformat.sh in=$i out=$(basename $i | sed 's/fastq/fasta/')
done
