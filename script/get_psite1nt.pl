use List::Util qw( min max );
open D, "<$ARGV[0]";
open O, ">$ARGV[0].txt";
while(<D>)
{
chomp;
@data=split/\t/,$_;
$name=shift @data;
$name=~/(.*?) nt reads/g;
$name=$1;
if($name<16)
    {
    next;
    }
$min=min@data;
$max=max@data;
for ($i=0;$i<scalar @data;$i++)
    {
        if($data[$i] eq $max )
        {
	$n=$i+1;
            print O "$name\t$n\n";
            break;
        }
        
    }

}



