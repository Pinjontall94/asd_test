#!/bin/bash

#groupFormatter(){
	# Description: Scans current directory for .fasta files, and
	#              formats them for use with the R package Mothur's
	#              'make.group()' command

	# Create hyphen-delimited lists for fastas and groups
	formatter_fastas=$(joinBy - ${in_file[*]})
	for i in ${in_file[@]}; do
		group_array+=("$AUTHOR"_"${i%%.*}")
	done
	formatter_groups=$(joinBy - ${group_array[*]})

	# Set mothur command parameters and run mothur
	group_params=("fasta=$formatter_fastas," "groups=$formatter_groups,"\
		"output=$AUTHOR.groups")
	mothur <(mothurBatch make group "${group_params[*]}")
#}
