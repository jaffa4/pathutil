
class Path::Util;

has $.filename;
has $.basename;
has $.justname;
has $.ext;
has $.filedir;
has $.separator;

method extension
{
 return $!ext;
}

method dir
{
 return $!filedir;
}

method directory
{
 return $!filedir;
}

constant $basenamereg = /<[\\\/]>?(<-[\\\/]>+)$/;

constant $justnamereg =/(<-[\\\/]>+?)[\.<-[.\/\\]>+]?$/;

constant $extreg = /<[.]>(<-[\\\/.]>+?)$/;

constant $filedirreg = /^(.+)<[\\\/]>/;

constant $sepreg = /(<[\\\/]>)/;

method new($filename) {

  #definitions

  my $basename = ( $filename ~~ $basenamereg ).list[0].Str;

  my $justname = ( $basename ~~ $justnamereg )[0].Str;
  my $ext      = ( $filename ~~ $extreg )[0].Str;
  my $filedir  = ( $filename ~~ $filedirreg )[0].Str;
  my $sep = "";
  
  if ($filename ~~ $sepreg )
  {
    $sep = $/[0].Str;
  }
  
  self.bless( filename => $filename, justname => $justname, ext => $ext, filedir => $filedir, basename => $basename, separator => $sep );
}

   
method print {
  say "filedir:" ~ $!filedir;
  say "basename:" ~ $!basename;
  say "justname:" ~ $!justname;
  say "ext:" ~$!ext;
}


#Path::Util.test();




method getfullfilename
{
  return $!filename;
}




method getbasename($filename?)
{
  if (self)
  {
   return $!basename;
  }
  else
  {
   return ($filename ~~ $basenamereg )[0].Str;
  }
}


method getseparator($filename?)
{
  if (self)
  {
   return $!separator;
  }
  else
  {
   return ($filename ~~ $sepreg )[0].Str;
  }
}



method getjustname($filename?)
{
 
  if (self)
  {
    return $!justname;
  }
  else
  {
    
    return (self.getbasename($filename) ~~ $justnamereg )[0].Str;
  }
}



method getext($filename?)
{
  
  if (self)
  {
  return $!ext;
  }
  else
  {
    if ($filename ~~ $extreg )
    {
      return $/[0].Str;
    }
    return "";
  }
  
}




method getdir($filename?)
{
  if (self)
  {
    return $!filedir;
  }
  else
  {
    my ($dir)= ( $filename ~~ $filedirreg )[0];  
    return $dir;
  }
}


method getnumberofdirlevel($filename?)
{

my $filenamelocal; 
if (self)
  {
    $filenamelocal=$!filename;
  }
  else
  {
   $filenamelocal = $filename;
  }
    my $level=0;
   # say $filenamelocal;
  #  my $m =  ($filenamelocal  ~~ m:g/<[\\\/]><before .>/);
    my @list = comb(/<[\\\/]><before .>/,$filenamelocal);
 #   say +@list;
 #   say +$m.lol;
    {
     $level+=+@list;
    }
    return $level;
}



method getdirlevel($level,$dirname?)
{
my $filenamelocal; 
if (self)
  {
    $filenamelocal=$!filename;
  }
  else
  {
   $filenamelocal = $dirname;
  }

my $llevel = $level+1;
#my @list = comb(/<[\\\/]><before .>/,$filenamelocal);
say $filenamelocal;

    while ( $filenamelocal ~~ m:c/<[\\\/]><before .>/)
    {
     $llevel--;
     last if $llevel <= 0;
    }
if ($/!~~ Nil)
{    
return substr($filenamelocal,0,$/.to-1);
}
else
{
return $filenamelocal;
}
}

method test 
{
say Path::Util.new("c:\\g\\b.mp4").getfullfilename();
say Path::Util.new("c:\\g\\b.mp4").print;
say ".basename:"~Path::Util.new("c:\\g\\b.mp4").basename;
say "getbasename:"~Path::Util.new("c:\\g\\c.mp4").getbasename();
say "getbasename2:"~Path::Util.getbasename("c:\\g\\c.mp4");

say "getjustname:"~Path::Util.new("c:\\g\\c.mp4").getjustname();
say "getjustname2:"~Path::Util.getjustname("c:\\g\\c.mp4");

say "getext:"~Path::Util.new("c:\\g\\c.mp4").getext();
say "getext2:"~Path::Util.getext("c:\\g\\c.mp4");

say "getdir:"~Path::Util.new("c:\\g\\c.mp4").getdir();
say "getdir2:"~Path::Util.getdir("c:\\g\\c.mp4");

say "getnumberofdirlevel:"~Path::Util.new("c:\\g\\c.mp4").getnumberofdirlevel();
say "getnumberofdirlevel2:"~Path::Util.getnumberofdirlevel("c:\\g\\c.mp4");
say "getdirlevel:"~Path::Util.new("c:\\g\\c.mp4").getdirlevel(0);
say "getdirlevel2:"~Path::Util.getdirlevel(0,"c:\\g\\c.mp4");
say "getdirlevel:"~Path::Util.new("c:\\g\\c.mp4").getdirlevel(1);
say "getdirlevel2:"~Path::Util.getdirlevel(1,"c:\\g\\c.mp4");
say "getdirlevel:"~Path::Util.new("c:\\g\\c.mp4").getdirlevel(2);
say "getdirlevel2:"~Path::Util.getdirlevel(2,"c:\\g\\c.mp4");
say "fsseparator:"~ Path::Util.fsseparator;
say "separator:"~ Path::Util.new("c:\\g\\c.mp4").separator;
say "separator2:"~ Path::Util.getseparator("c:\\g\\c.mp4");
}


method fsseparator
{
if ($*OS!~~m:i/mswin/)
   {
    return '/';
   }
 else
 {
  return '\\';
 }  
}




