#!/usr/bin/perl


my $headerflag = 0;

foreach my $a (@ARGV) {

    if ($a eq "-h") {
        $headerflag = 1;
        next;
    }

    
    my $h = "

#ifndef H__$a
#define H__$a

int $a (int a, int b);

#endif
";

    my $c = "

#include \"$a.h\"

int $a (int a, int b) {
    return a + b; 
}

";


    if ($headerflag) {
        print $h;
    } else {
        print $c;
    }
    
}
