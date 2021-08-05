###########################################################
# Snakemake pipeline to count kmers in fasta or fastq files
###########################################################

############
# Librairies
############
import pandas as pd

configfile: "config/config.yaml"

RESULT_DIR = config["result_dir"]
WORKING_DIR = config["working_dir"]


######################################
# TODO: Validate the 'samples.tsv' dataframe
# Check issue #1
######################################



################################################################
# Get list of unique sample names for Snakemake wildcards.sample
#################################################################

samples_df = pd.read_table("config/samples.tsv", dtype = str)
SAMPLES = samples_df["sample"].unique().tolist()
samples_df = samples_df.set_index("sample")

################
# Util functions
################

def get_fastq_or_fasta_files(wildcards):
    """This function returns the name of the fastq files"""
    return samples_df.loc[(wildcards.sample), ["path_to_seqfile"]]

################
# Desired output
################

rule all:
    input:
        KMER_COUNTS = expand(RESULT_DIR + "{sample}.counts.tsv", sample = SAMPLES)

#######
# Rules
#######

rule jellyfish_count:
    input: 
        get_fastq_or_fasta_files
    output:
        WORKING_DIR + "{sample}.counts.jf"
    message:
        "Count k-mer occurences in {wildcards.sample} {input} file"
    threads: 10
    params:
        mer_length = config["jellyfish"]["mer_length"],
        min_quality_base = config["jellyfish"]["min_quality_base"],
        memory_allocation = config["jellyfish"]["memory_allocation"]
    shell:
        "jellyfish count "
        "--canonical "                                # Count both strands (canonical)
        "--mer-len {params.mer_length} "
        "--min-qual-char={params.min_quality_base} "
        "--size {params.memory_allocation} "   
        "-o {output}"

rule jellyfish_dump:
    input:
        WORKING_DIR + "{sample}.counts.jf"
    output:
        RESULT_DIR + "{sample}.counts.tsv"
    message:
        "Output list of k-mers with their counts in human-readable format for {wildcards.sample}"
    shell:
        "jellyfish dump --column  --tab -o {output}"
   
