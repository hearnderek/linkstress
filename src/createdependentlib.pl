#!/usr/bin/perl


my $headerflag = 0;
my $file = @ARGV[0];

my $h = "

#ifndef H__$file
#define H__$file

int $file (int a, int b);

#endif
";

my $includes = "
#include \"$file.h\"
";

my $uses = "\n";

my $i = -1;
foreach my $a (@ARGV) {
    $i = $i + 1;
    if ($i eq 0) {
        next;
    } 
    if ($a eq "-h") {
        $headerflag = 1;
        next;
    }
    $includes = $includes . "#include \"$a.h\"\n";
    $uses = $uses . "    sum += $a(a, b);\n";
}

my $c = "

$includes

int $file (int a, int b) {
    int sum = 0;
    $uses
    return sum; 
}

";


    

if ($headerflag) {
    print $h;
} else {
    print $c;
}
