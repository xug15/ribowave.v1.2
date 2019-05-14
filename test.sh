#!/bin/sh

out=$PWD/GSE52799;
mkdir -p $out;
scripts=$PWD/script;
annotation=$PWD/annotation_fly;
cores=8;

mkdir annotation/
#       Pre-processing
##	Create annotation
$scripts"/create_annotation2.sh" -G $annotation/dmel-all-r6.18.gtf -f $annotation/dmel-all-chromosome-r6.18.fasta  -o annotation/  -s $scripts;
echo ""
echo "---------------"
echo ""

