#!/usr/bin/perl

###################################################################
##    This file is part of RiboWave.
##    RiboWave is powerful Ribo-seq analysis tool that is able to 
##    denoise the Ribo-seq data and serve for multiple functions.
##	
##    RiboWave can be used for multiple purposes: 
##    		1. denoise the raw Ribo-seq data
##		2. define translated ORFs
##		3. estimate the abundance of actively elongating ribosomes
##		4. estimate translation efficiency(TE)
##		5. identify potential frameshift candidates
##    
##    Author: Long Hu
##
##    Copyright (C) 2017  Zhiyu Xu
##
##    RiboWave is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
##
##    Contact: xanthexu18@gmail.com
########################################################################
use strict;
use warnings;

### header not considered here, the output file will inherit the order of row of the input file. 
open FileA	,	"$ARGV[0]" or die; ##first column is the ID, second and latter is one value of prob, all line are outputted
open FileB	,	"$ARGV[1]" or die; ##first column is the IDs.
open OUT	,	">$ARGV[2]" or die;##output matched lines 
my $line	=	"";
my %hashTarget;
my $name;
while($line=<FileB>){
	chomp($line);
        $line=~s/\([+-]\)//g;
	my @arr	=	split /\t/,	$line;
	$hashTarget{$arr[0]}=$line;
}

while($line=<FileA>){
        chomp($line);
        $line=~s/\([+-]\)//g;
	my @arr =       split /\t/,     $line;
	$name=$arr[0];
        $name=~s/\([+-]\)//g;
        if(defined($hashTarget{$name})){
                print OUT "$line\n";
        }
}


