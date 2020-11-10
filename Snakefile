rule srrMunch:
    input:
        "SraRunTable.txt"
        "SRR_Acc_List.txt"
    output:
        "fastqs/read_1.fastq"
        "fastqs/read_2.fastq"
    shell:

rule mergeSeqs:
    input:
        "fastqs/read_1.fastq"
        "fastqs/read_2.fastq"
    output:
        "merged_fastqs/read.fastq"
    shell:
        "bbmerge.sh in1={input} in2={input} out={output}"
        "./scripts/mergeSeqs.sh"


rule q2aReformat:
    input:
        "merged_fastqs/read.fastq"
    output:
        "fastas/read.fasta"
    shell:
        "./scripts/q2aReformat.sh"

rule groupFormatter:
    input:
        "fastas/read.fasta"
    output:
        "mothur_in/author.group"
    shell:
        "./scripts/groupFormatter.sh"

rule trimLoop:
    input:
        "fastas/read.fasta"
    output:
        "trimmed/read.fasta"
    shell:
        "./scripts/trimLoop.sh"

rule offsetTrim:
    input:
        "trimmed/read.fasta"
    output:
        "offset/read.fasta"
    shell:
        "./scripts/offsetTrim.sh"

rule phixScreen:
    input:
        "trimmed/read.fasta"
        "offset/read.fasta"
    output:
        "screened/author.concat.fasta"
        "screened/author.PhiX"
    shell:
        "./scripts/phixScreen.sh"

rule mothurScreen:
    input:
        "screened/author.concat.fasta"
        "mothur_in/author.groups"
    output:
        "mothur_out/author"
    shell:
        "./scripts/mothurScreen.sh"

rule groupSplit:
    input:
        "mothur_out/good.fasta"
    output:
        "split/read.fasta"
    shell:
        "./scripts/groupSplit.sh"

rule fastaHeaderrelabel:
    input:
        "split/read.fasta"
    output:
        "barcoded/read.fasta"
    shell:
        "./scripts/fastaHeaderrelabel.sh"
