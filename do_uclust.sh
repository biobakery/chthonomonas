#! /usr/bin/sh

gunzip all.fna.gz
usearch8.1.1861_i86osx32 -cluster_fast all.fna -id 0.95 -centroids nr2.fasta --log usearch.log --uc results2.uc