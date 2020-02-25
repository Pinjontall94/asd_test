#!/bin/bash
#SBATCH --partition=production
#SBATCH --job-name=primer_trim # this can be changed to whatever you want
#SBATCH --nodes=1
#SBATCH --ntasks=20 # Number of cores to be used
#SBATCH --time=08:00:00  # Time in hours:min:sec
#SBATCH --output=primer_trim.out # this can be changed to whatever you want
#SBATCH --error=primer_trim.err # same as above
#SBATCH --mail-user=sbjohnson@ucdavis.edu # put in your email address
#SBATCH --mail-type=ALL

aklog

date

trim_loop(){
	F=$(head -n 1 ../*primers.txt)
	
	R=$(tail -n 1 ../*primers.txt)
	
	module load cutadapt/2.0
	
	for x in *.fasta; do
		m=$(basename $x | sed 's/\.fasta//')
		
		cutadapt -g $F -o $m.temp.fasta $x --discard-untrimmed
		cutadapt -a $R -o $m.trimmed.fasta $m.temp.fasta --discard-untrimmed
		
	done
}

for i in *; do 
	if [ -d $i/primer_screening/fastas ]; then 
		cd $i/primer_screening/fastas/ 
		trim_loop 
		cd ../../../ 
	else 
		continue; 
	fi; 
done

date
