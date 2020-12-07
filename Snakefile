
#TODO: use 16S filter to generate accno list for use in config file
configfile: "config.yaml"

rule all:
    input:
        "outputs/author.barcoded.fasta"

rule srrMunch:
    input:
        runtable="SraRunTable.txt"
        acc="SRR_Acc_List.txt"
    output:
        "fastqs/{sample}.fastq"
    script:
        "scripts/srrMunch.sh {input.runtable} {input.acc}"

rule mergeSeqs:
    input:
        fwd="fastqs/{sample}_1.fastq"
        rev="fastqs/{sample}_2.fastq"
    output:
        "merged_fastqs/{sample}.fastq"
    shell:
        "bbmerge.sh in1={input.fwd} in2={input.rev} out={output}"

rule q2aReformat:
    input:
        "merged_fastqs/{sample}.fastq"
    output:
        "fastas/{sample}.fasta"
    shell:
        "./scripts/q2aReformat.sh"

rule groupFormatter:
    input:
        "fastas/{sample}.fasta"
    output:
        "mothur_in/author.group"
    shell:
        "./scripts/groupFormatter.sh"

rule trimLoop:
    input:
        "fastas/{sample}.fasta"
    output:
        "trimmed/{sample}.fasta"
    shell:
        "./scripts/trimLoop.sh"

rule offsetTrim:
    input:
        "trimmed/{sample}.fasta"
    output:
        "offset/{sample}.fasta"
    shell:
        "./scripts/offsetTrim.sh"

rule phixScreen:
    input:
        "trimmed/{sample}.fasta"
        "offset/{sample}.fasta"
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
        "split/{sample}.fasta"
    shell:
        "./scripts/groupSplit.sh"

rule fastaHeaderrelabel:
    input:
        "split/{sample}.fasta"
    output:
        "barcoded/author.barcoded.fasta"
    shell:
        "./scripts/fastaHeaderrelabel.sh"
