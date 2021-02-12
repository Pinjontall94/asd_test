
#TODO: use 16S filter to generate accno list for use in config file
configfile: "config.yaml"

#rule all:
#    input:
#        "outputs/study.barcoded.fasta"

rule srrMunch:
    input:
        "SRR_Acc_List.txt"
    output:
        protected("fastqs/{sample}.fastq")
    log:
        "logs/srrMunch/{sample}.log"
    script:
        "(while read accno; do "
        "fasterq-dump --split-3 --gzip $accno"
        "done < {input}) 2> {log}"

#rule mergeSeqs:
#    input:
#        fwd="fastqs/{sample}_1.fastq",
#        rev="fastqs/{sample}_2.fastq"
#    output:
#        "merged_fastqs/{sample}.fastq"
#    log:
#        "logs/mergeSeqs/{sample}.log"
#    shell:
#        "bbmerge.sh in1={input.fwd} in2={input.rev} out={output}"
#
#rule q2aReformat:
#    input:
#        "merged_fastqs/{sample}.fastq"
#    output:
#        "fastas/{sample}.fasta"
#    shell:
#        "./scripts/q2aReformat.sh"
#
#rule groupFormatter:
#    input:
#        "fastas/{sample}.fasta"
#    output:
#        "mothur_in/study.group"
#    shell:
#        "./scripts/groupFormatter.sh"
#
#rule trimLoop:
#    input:
#        "fastas/{sample}.fasta"
#    output:
#        "trimmed/{sample}.fasta"
#    shell:
#        "./scripts/trimLoop.sh"
#
#rule offsetTrim:
#    input:
#        "trimmed/{sample}.fasta"
#    output:
#        "offset/{sample}.fasta"
#    shell:
#        "./scripts/offsetTrim.sh"
#
#rule phixScreen:
#    input:
#        "trimmed/{sample}.fasta"
#        "offset/{sample}.fasta"
#    output:
#        "screened/study.concat.fasta"
#        "screened/study.PhiX"
#    shell:
#        "./scripts/phixScreen.sh"
#
#rule mothurScreen:
#    input:
#        "screened/study.concat.fasta"
#        "mothur_in/study.groups"
#    output:
#        "mothur_out/study"
#    shell:
#        "./scripts/mothurScreen.sh"
#
#rule groupSplit:
#    input:
#        "mothur_out/good.fasta"
#    output:
#        "split/{sample}.fasta"
#    shell:
#        "./scripts/groupSplit.sh"
#
#rule fastaHeaderrelabel:
#    input:
#        "split/{sample}.fasta"
#    output:
#        "barcoded/study.barcoded.fasta"
#    shell:
#        "./scripts/fastaHeaderrelabel.sh"
