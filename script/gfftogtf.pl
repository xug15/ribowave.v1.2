open DATA, "<$ARGV[0]";
open OUT, ">$ARGV[0].clean.gtf";
while(<DATA>){
    chomp;
    if($_=~/^#/| $_=~/chromosome/){
        next;
    }
    $_=~s/three_prime_UTR/3UTR/g;
    $_=~s/five_prime_UTR/5UTR/g;
    $_=~s/The Arabidopsis Information Resource/araport11/g;

    @data=split/\t/,$_;


    my @info;
    if($data[2]=~/gene/|$data[2]=~/ncRNA_gene/){
        if($data[8]=~/gene_id=(.*?);/){
            #print "gene_id \"$1\"\n";
            push @info, "gene_id \"$1\"";

        }
        if($data[8]=~/Name=(.*?);/){
            #print "gene_symbol \"$1\"\n";
            push @info, "gene_symbol \"$1\"";
        }
    }
    if($data[2]=~/mRNA/){
        if($data[8]=~/Parent=gene:(.*?);/){
            #print "gene_id \"$1\"\n";
            push @info, "gene_id \"$1\"";
        }
        if($data[8]=~/transcript_id=(.*?)$/){
            #print "transcript_id \"$1\"\n";
            push @info, "transcript_id \"$1\"";
        }
    }

    if($data[2]=~/exon/){
        if($data[8]=~/transcript:(.*?)\.\d+;/)
        {
            #print "gene_id \"$1\"\n";
            push @info, "gene_id \"$1\"";
        }
        if($data[8]=~/transcript:(.*?);/)
        {
            #print "transcript_id \"$1\"\n";
            push @info, "transcript_id \"$1\"";
        }
    }

    if($data[2]=~/CDS/){
        if($data[8]=~/CDS:(.*?)\.\d+;/)
        {
            #print "gene_id \"$1\"\n";
            push @info, "gene_id \"$1\"";
        }
        if($data[8]=~/CDS:(.*?);/)
        {
            #print "transcript_id \"$1\"\n";
            push @info, "transcript_id \"$1\"";
        }
    }

    if($data[2]=~/5UTR/ | $data[2]=~/3UTR/)
    {
        #print "$_\n";
        if($data[8]=~/Parent=transcript:(.*?)\.\d+$/)
        {
            #print "gene_id \"$1\"\n";
            push @info, "gene_id \"$1\"";
        }
        if($data[8]=~/Parent=transcript:(.*?)$/)
        {
            #print "transcript_id \"$1\"\n";
            push @info, "transcript_id \"$1\"";
        }
    }

    if($data[2]=~/miRNA/ | $data[2]=~/^ncRNA$/ |$data[2]=~/lnc_RNA/ |$data[2]=~/rRNA/ |$data[2]=~/snoRNA/ |$data[2]=~/tRNA/|$data[2]=~/snRNA/)
    {
        #print "$_\n";
        if($data[8]=~/gene:(.*?);/)
        {
            #print "gene_id \"$1\"\n";
            push @info, "gene_id \"$1\"";
        }
        if($data[8]=~/transcript_id=(.*?)$/)
        {
            #print "transcript_id \"$1\"\n";
            push @info, "transcript_id \"$1\"";
        }
    }


    $data[8]=join(";",@info);

    $print=join("\t",@data);    
    if($#data=8){
        print OUT  $print."\n";
    }
}

