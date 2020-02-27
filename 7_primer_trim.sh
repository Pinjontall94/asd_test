#!/bin/bash
# primer_trim.sh

# Takes the primer patterns in the directory above 
# $(pwd), inputs to cutadapt, and loops through all fasta # files in $(pwd)

# INPUT: *primers.txt,*.fasta
# OUTPUT: *.trimmed.fasta


trim_loop(){
F=$(head -n 1 *primers.txt)

R=$(tail -n 1 *primers.txt)

#module load cutadapt/2.0 # comment out when on local machine!

for x in *.fasta; do
m=$(basename $x | sed 's/\.fasta//')

echo "Test run on $x as \$x, $m as \$m"
echo "Forward = $F" && echo "Reverse = $R"
cutadapt -g $F -o $m.temp.fasta $x --discard-untrimmed
cutadapt -a $R -o $m.trimmed.fasta $m.temp.fasta --discard-untrimmed
done
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
