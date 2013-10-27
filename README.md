pathutil
========




Path::Util

Break up a file path into its components.

Usage:


use Path::Util;


my $p = Path::Util.new("d:\\docs\\usage.txt");<br>
say $p.getdir;<br>
say $p.getext;<br>
say $p.getbasename;  # returns the filename without directory<br>
say $p.getjustname;  # returns the filename without directory and extension<br>

Above also work without get.

say $p.print; # prints all components

say $p.separator; # returns Windows or Unix-like file separator depending where you run your script

say $p.getnumberofdirlevel; # number of levels in the directory

say $p.getdirlevel(2); # returns directory up to the second level

Also, it is possible to use them non-object oriented way. 

say Path::Util.getbasename("d:\\docs\\usage.txt");

Extension is returned without dot.
Directories are returned without ending separator.


