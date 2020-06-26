#!/bin/bash
# 16S_extractor.sh
# Description: A tool that takes an SraRunTable file from NCBI and outputs all
# 		SRR's that contain "16S"
#
# LICENSE: AGPL-3.0-or-later

# INPUT: SraRunTable.csv
# OUTPUT: 16S/,*.fastq

FPRIMER="GTGCCAGC(A|C)GCCGCGGTAA"
RUNTABLE=SraRunTable.txt

mkdir 16S_temp filter
if [ -f $RUNTABLE ]; then
	awk -F "," '/16S/ { print $1 }' $RUNTABLE > 16S_list.txt.temp
	while read line; do
		echo "$line.fastq"
		eval mv $line*.fastq 16S_temp
	done < 16S_list.txt.temp
	rm 16S_list.txt.temp
	mv *.fastq filter 
	mv 16S_temp/* . && rmdir 16S_temp
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
        echo "Error: No fastq files found in current directory"
fi
