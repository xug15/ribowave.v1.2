grep $'\t'start_codon$'\t' $1 >> $2
grep $'\t'stop_codon$'\t' $1  >> $2

grep $'\t'transcript$'\t' $1  >> $2
sort -k1,1 -k4,4n $2 > $2.clean.sort.gtf


