#!/bin/bash
# 16S_extractor.sh
# Description: A tool that takes an SraRunTable file from NCBI and outputs all
# 		SRR's that contain "16S"

FPRIMER="GTGCCAGC(A|C)GCCGCGGTAA"
RUNTABLE=SraRunTable.csv

if [ -f *.fastq ] && [ ! -d 16S ]; then
	mkdir 16S 
	if [ -f SraRunTable.csv ]; then
		awk -F "," '/16S/ { print $1 }' $RUNTABLE > 16S_list.txt.temp
#		awk -F "," '/16S/ { print $1 }' $RUNTABLE > 16S_list.txt.temp
		while IFS= ; do read line
			echo "$line"
			mv $line 16S
		done < 16S_list.txt.temp
		rm 16S_list.txt.temp
	else	
		echo "No SraRunTable.csv found! Try grep -B 1 -E \"<FORWARD PRIMER>\" on fastqs"
		echo "\nExample output:"
		grep -EB 1 $FPRIMER
		# Put grep tool for generating 16S list here 
		# 	(Note: Add both "FPRIMER" __and__ "^FPRIMER" versions, and separate
		# 	their results in different directories)
#	        head -n 2 *.fastq \
#	        | grep -EB 1 $FPRIMER \
#	        | grep -o "SRR[0-9]\+" \
#	        | sed 's/$/.fastq/'
        	echo "Error! No fasta or fastq files found in current directory"
	fi
fi
