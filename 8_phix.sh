#!/bin/bash
# phix.sh

# DESCRIPTION: Takes in a fasta file, phix databases in a directory named 
# 	$PWD/phix_db/ and screens for PhiX contamination

# Deps: bowtie2
# Note: RUN AFTER: --- mothur > ~/code/shell/bioinf/screening_batch.txt
#	RUN BEFORE: -- mothur > ~/code/shell/bioinf/phix_removal_batch.txt
# INPUT: samples.trim.contigs.fasta
# OUTPUT: merged.bowtie,merged.PhiX,PhiX.accnos

bowtie2 -x phix_db/PhiX_bowtie_db.* -f -U *merged.extendedFrags.trimmed.fasta -S merged.bowtie --un merged.screened --al merged.PhiX --local -p 2

echo "PhiX screened, generating PhiX accession number file..."
grep ">" merged.PhiX >> PhiX.accnos

#if [ -s PhiX.accnos ]; then
#    while IFS= ; do read line
#                    grep -v -B 1 "$line" >> clean.merged.fasta
#    done < PhiX.accnos
#else echo "No PhiX detected, renaming merged.fasta for pipeline compatibility"
#     mv merged.fasta clean.merged.fasta
#fi
