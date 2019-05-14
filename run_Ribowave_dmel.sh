#!/bin/sh

out=$PWD/GSE52799;
mkdir -p $out;
scripts=$PWD/script;
annotation=$PWD/annotation_fly;
cores=8;

#       Pre-processing
##	Create annotation
#$scripts"/create_annotation.sh" -G $annotation/dmel-all-r6.18.gtf -f $annotation/dmel-all-chromosome-r6.18.fasta  -o $annotation  -s $scripts;
echo ""
echo "---------------"
echo ""


##      P-site detemination
$scripts"/P-site_determination.sh"  -i  $out/SRR1039770.sort.bam  -S $annotation/start_codon.bed  -o $out      -n SRR1039770   -s $scripts;
echo ""
echo "---------------"
echo ""

##      Creating P-site track
$scripts"/create_track_Ribo.sh"  -i $out/SRR1039770.sort.bam  -G $annotation/X.exons.gtf  -g $annotation/genome  -P $out/P-site/SRR1039770.psite1nt.txt -o $out -n SRR1039770 -s $scripts;
echo ""
echo "---------------"
echo ""


#       Main function
##      denoise raw signal 
mkdir -p $out/Ribowave;
$scripts"/Ribowave"  -a $out/bedgraph/SRR1039770/final.psite -b $annotation/final.ORFs -o $out/Ribowave   -n SRR1039770 -s $scripts -p 8;
echo ""
echo "---------------"
echo ""

##      predict p.value of translation
mkdir -p $out/Ribowave;
$scripts"/Ribowave"  -P -a $out/bedgraph/SRR1039770/final.psite -b $annotation/final.ORFs -o $out/Ribowave   -n SRR1039770 -s $scripts -p 8;
echo ""
echo "---------------"
echo ""

##      estimate abundance/density
mkdir -p $out/Ribowave;
$scripts"/Ribowave"  -D -a $out/bedgraph/SRR1039770/final.psite -b $annotation/final.ORFs -o $out/Ribowave   -n SRR1039770 -s $scripts -p 8;
echo ""
echo "---------------"
echo ""

##      calculating TE
$scripts"/Ribowave" -T 9012445  $out/mRNA/SRR1039761.RPKM -a $out/bedgraph/SRR1039770/final.psite -b $annotation/final.ORFs -o $out/Ribowave   -n SRR1039770 -s $scripts -p 8;
echo ""
echo "---------------"
echo ""

##      calculating frameshift potential
#	on annotated ORF
mkdir -p $out/Ribowave;
awk -F '\t' '$3=="anno"'	$annotation/final.ORFs	>	$annotation/aORF.ORFs;
$scripts"/Ribowave" -F -a $out/bedgraph/SRR1039770/final.psite -b $annotation/aORF.ORFs -o $out/Ribowave   -n SRR1039770 -s $scripts -p 8;
echo ""
echo "---------------"
echo ""

##      multiple functions
mkdir -p $out/Ribowave;
$scripts"/Ribowave" -PD -T 9012445  $out/mRNA/SRR1039761.RPKM -a $out/bedgraph/SRR1039770/final.psite -b $annotation/final.ORFs -o $out/Ribowave   -n SRR1039770 -s $scripts -p 8;
echo ""
echo "---------------"
echo ""

