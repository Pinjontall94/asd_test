#!/bin/sh

# groupFormatter.sh
# Description: Scans current directory for .fasta files, and
#              formats them for use with the R package Mothur's
#              'make.group()' command

# NOTE: RUN AFTER: --- q2a_reformat.sh 
# 	RUN BEFORE: -- [mothur merge script]

# Ex: mothur > make.group(fasta=sample1.fasta-sample2.fasta-sample3.fasta, groups=A-B-C)


