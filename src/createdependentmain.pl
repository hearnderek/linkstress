#!/usr/bin/perl


my $headerflag = 0;
my $file = @ARGV[0];

my $includes = "";

my $uses = "\n";

my $i = -1;
foreach my $a (@ARGV) {
    $i = $i + 1;
    if ($i eq 0) {
        next;
    } 
    $includes = $includes . "#include \"$a.h\"\n";
    $uses = $uses . "    sum += $a($i, $i);\n";
}

my $c = "

$includes
#include <stdio.h>

int main (int argc, char * argv[]) {
    int sum = 0;
    $uses
    printf(\"%i\\n\", sum);
    return 0; 
}

";
    

print $c;
