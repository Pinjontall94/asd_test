#!/bin/sh

# q2a_reformat.sh

# DESCRIPTION: Reformats all fastq files in current directory to fasta

# Deps: bbtools 'reformat' tool

# NOTE: RUN AFTER: --- flash2_merge.sh
#	RUN BEFORE: -- groupFormatter.sh

# INPUT: *.merged.fastq
# OUTPUT: *.merged.fasta

for i in *.merged.extendedFrags.fastq; do
	#./reformat.sh in=$i out=$(basename $i | sed 's/fastq/fasta/') # if bbmap is local binary
	reformat.sh in=$i out=$(basename $i | sed 's/fastq/fasta/') # if bbmap is in PATH
done
