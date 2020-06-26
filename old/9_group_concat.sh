#!/bin/bash
# group_concat.sh
# Concat all *trimmed*fasta files in current directory
# LICENSE: AGPL-3.0-or-later

for x in *trimmed*; do
	#echo "Dry run of cat $x to $(basename $x | sed 's/_.*$//').trimmed.concat.fasta"
	cat $x >> $(basename $x | sed 's/_.*$//').trimmed.concat.fasta
done
