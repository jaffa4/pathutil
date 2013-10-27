 
 my $str = "aaaaa";
 
# $str ~~ gc/a/;
 
 say $/.perl;
 
# $str ~~ gc/a/;
 
 say $/.perl;
 
 while ($str ~~ c/a/) 
{
  say "me";
}

