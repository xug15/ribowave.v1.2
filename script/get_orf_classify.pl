open I, "<$ARGV[0]";
open O, ">$ARGV[0].ORF.classify.txt";
my(%hash,%begin,%end);
while(<I>){
    chomp;
    @data=split/\t/,$_;
    $data[0]=~/(.*?)_\d+_\d+/g;
    $name=$1;
    if($data[2]=~/^anno$/){
        #print "$name\t$_\n";
        $begin{$name}=$data[4];
        $end{$name}=$data[5];
    }
}
close I;
open I, "<$ARGV[0]";
while(<I>)
{
    chomp;
    @data=split/\t/,$_;
    $data[0]=~/(.*?)_\d+_\d+/g;
    $name=$1;
    if($data[2]=~/^anno$/){
        print O  "$_\tAnnotated\n";
    }
    if($data[2]=~/^sharestop$/){
        if($begin{$name} > $data[4]){
            print O  "$_\tExtended\n";
        }elsif($begin{$name} < $data[4]){
            print O  "$_\tTruncated\n";
        }else{
            print "$_\n";
        }
    }
    if($data[2]=~/^unanno$/){
        if($data[5] <= $begin{$name} ){
            print O  "$_\tUpstream\n";
        }elsif($data[4] => $end{$name} ){
            print O  "$_\tDownstream\n";
        }elsif($data[4]<$begin{$name} & $data[5]>$begin{$name} & $data[5]<$end{$name} ){
            print O  "$_\tInternal\n";
        }elsif($data[4]>$begin{$name} & $data[5]<$end{$name}){
            print O  "$_\tInternal\n";
        }elsif($data[4]>$begin{$name} & $data[4]<$end{$name} & $data[5]>$end{$name}){
            print O  "$_\tInternal\n";
        }elsif(! exists($begin{$name})){
            print O  "$_\tUnanno\n";
        }else{
            print "$_\n";
        }
    }

}


