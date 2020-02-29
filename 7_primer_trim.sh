#!/bin/bash
# primer_trim.sh

# Takes the primer patterns in the directory above 
# $(pwd), inputs to cutadapt, and loops through all fasta # files in $(pwd)

# INPUT: *primers.txt,*.fasta
# OUTPUT: *.trimmed.fasta


trim_loop(){
FORPRIME=$(head -n 1 *primers.txt)

REVPRIME=$(tail -n 1 *primers.txt)

#module load cutadapt/2.0 # comment out when on local machine!

# Loop over merged fastas
#for x in *.fasta; do
#	m=$(basename $x .fasta)
#
#	cutadapt -b $FORPRIME -o $m.temp.fasta $x --discard-untrimmed
#	cutadapt -a $REVPRIME -o $m.trimmed.fasta $m.temp.fasta --discard-untrimmed
#done

# Loop over unmerged fastqs
shopt -s nullglob

PAT="[0-9]{4,}_1.fastq"
PAT_R="[0-9]{4,}_R1.fastq"

for i in *1.fastq; do                   # Merge all _1 & _2 fastqs
        if [[ $i =~ $PAT ]]; then
                SUF_REGX="s/_1\.fastq/_2.fastq/"
        elif [[ $i =~ $PAT_R ]]; then
                SUF_REGX="s/_R1\.fastq/_R2.fastq/"
        else
                exit 0
        fi      
        REV=$(basename "$i" | sed $SUF_REGX) 
	FOUT=$(basename $i .fastq).trimmed
	ROUT=$(basename $REV .fastq).trimmed
        echo "Trimming Reads for: $i" "$REV"
	echo "Forward primer: $FORPRIME"
	echo "Reverse primer: $REVPRIME"
	echo "Output files: Forward -> $FOUT ; Reverse -> $ROUT"
	cutadapt -a $FORPRIME -A $REVPRIME -o $FOUT -p $ROUT $i $REV
        done

shopt -u nullglob
}

#for i in *; do 
#	if [ -d $i/primer_screening/fastas ]; then 
#		cd $i/primer_screening/fastas/ 
		trim_loop 
#		cd ../../../ 
#	else 
#		continue; 
#	fi; 
#done
