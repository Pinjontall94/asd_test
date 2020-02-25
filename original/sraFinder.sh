#!/bin/bash
# sraFinder.sh

# AUTHOR: Samuel Johnson
# LICENSE: GNU Affero General Public License https://www.gnu.org/licenses/agpl-3.0.html
# DEPENDS: poppler-utils, bash


# Simple grep parser for all NCBI SRA accession numbers in pdf files in the working directory
# usage: <sraFinder.sh> 
shopt -s nullglob
if [[ ! -z $(ls | grep \.pdf) ]]; then
	for f in *.pdf; do
		pdftotext -layout $f # convert pdf files to parsable txt files
		r=$(echo $f | sed 's/\.pdf/.txt/')
		if [[ ! -z $(grep -Eo "[A-Z]{3,}[[:digit:]]{5,}" $r) ]]; then
			cat $r | grep -Eo "[A-Z]{3,}[[:digit:]]{5,}" $r > \
				$(echo $r | sed 's/\.txt//').sra
			# echo anything in txt that has =>3 capitals, followed
			# 	by => 5 numbers, into a new file with a ".sra"
			# 	extension (regex: [A-Z]{3,}[[:digit:]]{5,} )
		else 
			echo "No valid accession number found in file: $f"
		fi
		rm $r
	done
else 
	echo "Error: no valid .pdf files found in this directory!"
fi


# TO DO

# Perform web search (maybe with curl, lynx?) for SRA/PRJNA/etc number,
# 	bypass writing to a separate file, and autodownload SRA
#	accession list, etc.
#
# 	https://www.ncbi.nlm.nih.gov/sra/?term=<SRA NUMBER HERE>
# 	
# 	Must grab from run selector! e.g. for https://www.ncbi.nlm.nih.gov/bioproject/PRJNA561262
# 	Dang it, I can't find anything for the specific buttons for RunTableInfo and Accession List;
#	I don't know enough javascript to figure out how to connect to what those buttons do. Maybe
# 	NCBI has a CLI for grabbing this stuff?
#	Oh, it'd be a good idea to confirm the SRAs etc. grabbed from each paper before grabbing those
#	docs. So it'd have to be interactive....maybe this would be a good project to learn some
#	GUI skills for...
