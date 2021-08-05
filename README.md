# Snakemake pipeline to count k-mers in FASTA/FASTQ files

A Snakemake pipeline to create a table of count kmers from fasta/fastq files. 

# Pipeline input and output

## Input files
One or more FASTA or FASTQ files. 
Ideally the pipeline should check the compliance of each file to the FASTA/FASTQ format. 

## Desired output result (the skateboard)

|         	| sample_01 	| sample_02 	| sample_03 	| etc. 	|
|---------	|-----------	|-----------	|-----------	|------	|
| kmer_01 	| 10        	| 25        	| 15        	| ...  	|
| kmer_02 	| 11        	| 27        	| 18        	| ...  	|
| kmer_03 	| 12        	| 1         	| 97        	| ...  	|
| kmer_04 	| 15        	| 12        	| 15        	| ...  	|
| etc.    	| ...       	| ...       	| ...       	| ...  	|

# Useful links

## k-mer counting
- [k-mer counts nicely explained](https://bioinfologics.github.io/post/2018/09/17/k-mer-counting-part-i-introduction/)  
- [Phred score ASCI_BASE 33](https://www.drive5.com/usearch/manual/quality_score.html) used by Jellyfish version 2.2.3 and higher.



# Installation

## Step 1: clone the GitHub repository

`git clone git@github.com:MolPlantPathology/count_kmers.git` and `cd` into it.

## Step 2: install micromamba

`micromamba` is described [here](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html)  

1. `wget -qO- https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba`  
2. `./micromamba shell init`

## Step 3: create the micromamba 'kmers' environment
1. `micromamba create -f environment.yaml`
2. `micromamba activate kmers`


## Step 4: install 'dataset' with 'pip'

[**Dataset**](https://datatest.readthedocs.io/en/stable/index.html) is a Python package aimed at validating datasets.


On the command-line, type: `pip install dataset`

# Test

## Run a simple test

`micromamba activate kmers`  
`snakemake -j 1`






