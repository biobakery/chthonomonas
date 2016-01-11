#!/usr/bin/env python3
"""operon.py: Calculates Euclidean gene distances of a group of genes, such as genes involved in a pathway, within a gneome.
The script can handle multiple homologous groups (named "operons" here) within multiple genomes provided in a single dataset file.

#date            :20160112
#version         :0.2
#usage           :python operon.py
#python_version  :3.4.1  

Reads: "dataset.txt"
Writes: "distance_output.txt"

To generate input file ("dataset.txt"):
    The script takes Gene Cart tables exported from JGI's Integrated Microbial Genome database (https://img.jgi.doe.gov/).
        1. Place orthologous genes among different genomes within the gene cart.
        2. In gene cart menu, select "Start Coord", "End Coord", "Strand", and "Scaffold Length".
        3. Export the gene cart table data using the Export button below the table.
        4. Append a tabbed delimited column at the end of the table naming the gene (e.g. TrpA)
        5. Repeat the above process and collect orthologous genes within a pathway, and append another column naming the pathway (e.g. Tryptophan)
           within all the relevant files.
        6. Remove the header of each file and merge all files into a single file named "dataset.txt" within the working path of this script.
        7. The script can calculate arbitrary number of genes within arbitrary number of pathways within arbitrary number of genomes, given the
           consistent identifiers in the columns (genome name, gene name, and pathway name).
        
Note:
    1. Only distances between genes within a single contiguous chromosome is calculated. Comparing genes on separate
       chromosomes/plasmids will not make sense and will likely result in an error.
    2. Strandiness is only considered for calculating the ORF positions of the genes to be compared.
    
Calculation of Euclidean distances between genes:
    As the vast majority of prokaryotic chromosomes are circular, the geometry meant that there are two paths along the DNA molecule between any 
    two genes. This script outputs the shorter path.
    
Output (distance_output.txt):
    Through print() and writing a file "distance_output.txt"
    This script outputs:
        1. Name of the pathway
        2. Name of the genome
        3. Tab delimited Euclidean distances between genes of pathway (1) in genome (2)."""
import csv
import itertools
from collections import defaultdict
import sys

__author__ = "Kevin C. Lee"
__copyright__ = "Copyright 2015"
__credits__ = ["Kevin C. Lee", "Xochitl C. Morgan"]
__email__ = "cykevinlee@gmail.com"

# Input file format, dataset.txt is included to recreate the analysis.
reader = csv.reader(open('dataset.txt', 'r'), delimiter='\t')
operons = list(reader)

# Generate nested dictionary structure to load the data into.
tree = defaultdict(lambda: defaultdict(lambda: defaultdict(dict)))

# Observe the order of the columns. Start, end, strand, length, gene, operon are used for this analysis.
for img_id,locus_tag,gene_desc,genome,batch,start,end,strand,length,gene,operon in operons:
# Building a dict of the combo and assign it to the quadruple
# index tree address
    tree[operon][genome][gene] = dict(Strand = strand, Start = start, End = end, Length = length)

# Creating the result-collecting dictionary (key: operon leading to key:genome - value: distances).
result = defaultdict(dict)

# Cycle through operons.
for key1, value1 in tree.items():
    genome_dist = {}
    
    #Print and write the name of the pathway ("operon").
    print(key1)
    with open("distance_output.txt","a") as myfile:
        myfile.write("\n" + key1 + "\n")

    # Cycle through genomes, using opernic genes in the next level passed up for the list of gene combinations.
    for key2, value2 in tree[key1].items():
        ogenes=[]
        diff_a = 0
        diff_b = 0
        dp_genome=[] # pairwise gene distance per operon for a particular genome.
        aORF = 0
        bORF = 0
        total_length = 0
        print(key2 + "\t", end="")
        with open("distance_output.txt","a") as myfile:
            myfile.write(key2 + "\t")

        # Cycle through operonic genes.
        for key3, value3 in tree[key1][key2].items():
            #print("\n" + str(key2) + " " + str(key3))

            # Populate the opernic genes into a list.
            ogenes.append(key3)

        # Generate gene pair combinations.
        for genecomb in itertools.combinations(ogenes,2):
            gene_a = genecomb[0]
            gene_b = genecomb[1]

            # Genome total length assignment and error checking.
            if tree[key1][key2][gene_a]["Length"] != tree[key1][key2][gene_b]["Length"]:
                print("Genome total length between comparison pairs not equal!")
            else:
                total_length = int(tree[key1][key2][gene_a]["Length"])
            
            # Logic detecting which coordinate to use for open reading frame based on Strand.
            if tree[key1][key2][gene_a]["Strand"] == "+":
                aORF = tree[key1][key2][gene_a]["Start"]
            elif tree[key1][key2][gene_a]["Strand"] == "-":
                aORF = tree[key1][key2][gene_a]["End"]
            else:
                #Debug messages
                print("Warning, gene_a start-end calc error: " +tree[key1][key2][gene_a]["Strand"])
                sys.exit()
                
            if tree[key1][key2][gene_b]["Strand"] == "+":
                bORF = tree[key1][key2][gene_b]["Start"]
            elif tree[key1][key2][gene_b]["Strand"] == "-":
                bORF = tree[key1][key2][gene_b]["End"]
            else:
                #Debug messages
                print("Warning, gene_b start-end calc error: " +tree[key1][key2][gene_b]["Strand"])
                sys.exit()
          
            aORF = int(aORF)            
            bORF = int(bORF)
            
            # Logic for generating shortest absolute distances between two genes within a genome.
            if aORF > bORF:
                diff_a = aORF - bORF
            elif bORF > aORF:
                diff_a = bORF - aORF
            else:
                #Debug messages
                print("Errors in genome coordinate comparison!")
                print("aORF: " + str(aORF))
                print("bORF: " + str(bORF))
                print(tree[key1][key2][gene_a]["Strand"] + gene_a)
                print(tree[key1][key2][gene_b]["Strand"] + gene_b)
                print("gene_a start " + tree[key1][key2][gene_a]["Start"])
                print("gene_a end " + tree[key1][key2][gene_a]["End"])
                print("gene_b start " + tree[key1][key2][gene_b]["Start"])
                print("gene_b end " + tree[key1][key2][gene_b]["End"])
                print("gene_a strand: " + tree[key1][key2][gene_a]["Strand"])
                print("gene_b strand: " + tree[key1][key2][gene_b]["Strand"])
                sys.exit()
                                
            if aORF > bORF:
                diff_b = bORF + (total_length - aORF)
            elif bORF > aORF:
                diff_b = aORF + (total_length - bORF)
            else:
                #Debug messages
                print("Errors in genome coordinate comparison!")
                print("aORF: " + str(aORF))
                print("bORF: " + str(bORF))
                print(tree[key1][key2][gene_a]["Strand"] + gene_a)
                print(tree[key1][key2][gene_b]["Strand"] + gene_b)
                print("gene_a start " + tree[key1][key2][gene_a]["Start"])
                print("gene_a end " + tree[key1][key2][gene_a]["End"])
                print("gene_b start " + tree[key1][key2][gene_b]["Start"])
                print("gene_b end " + tree[key1][key2][gene_b]["End"])
                print("gene_a strand: " + tree[key1][key2][gene_a]["Strand"])
                print("gene_b strand: " + tree[key1][key2][gene_b]["Strand"])
                sys.exit()
                                            
            if diff_a < diff_b:
                dp_genome.append(diff_a)
            elif diff_b < diff_a:
                dp_genome.append(diff_b)
            else:
                print("Errors in genome coordinate comparison!")
                print("Please check your input dataset.")
                sys.exit()
                                
            if diff_a < 0 or diff_b < 0:
                print("Error in gerating Euclidean distances!" + "\n" + " Path 1: " + str(diff_a) + "\n" + "Path 2: " + str(diff_b ))
                print("Please check your input dataset.")
                sys.exit()
        
        #Print and write the genome and gene distances
        print(str(dp_genome))
        genome_dist[key2] = dp_genome
        result[key1] = genome_dist
        
        with open("distance_output.txt","a") as myfile:
            myfile.write('\t' .join((repr(e) for e in dp_genome)) + "\n")
               
        #Cleanup the variables.
        del ogenes, diff_a, diff_b, dp_genome, aORF, bORF, total_length