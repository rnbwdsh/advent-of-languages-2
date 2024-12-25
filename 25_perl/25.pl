#!/usr/bin/perl
use strict;
use warnings;

open(my $fh, '<', '25.in') or die $!;

my (@keys, @locks);
my $chunk = '';

while (<$fh>) {
    if ($_ eq "\n") {
        if ($chunk =~ /^#####/) {
            push @keys, $chunk;
        } else {
            push @locks, $chunk;
        }
        $chunk = '';
    } else {
        $chunk .= $_;
    }
}
if ($chunk =~ /^#####/) {
    push @keys, $chunk;
} else {
    push @locks, $chunk;
}

my $total = 0;
for my $key (@keys) {
    for my $lock (@locks) {
        my @key_lines = split /\n/, $key;
        my @lock_lines = split /\n/, $lock;
        my $match = 1;
        for my $i (0 .. $#key_lines) {
            my $key_line = $key_lines[$i];
            my $lock_line = $lock_lines[$i];
            next unless defined $key_line && defined $lock_line;
            for my $j (0 .. length($key_line) - 1) {
                my $key_char = substr($key_line, $j, 1);
                my $lock_char = substr($lock_line, $j, 1);
                if ($key_char eq '#' && $lock_char eq '#') {
                    $match = 0;
                    last;
                }
            }
            last unless $match==1;
        }
        $total++ if $match==1;
    }
}

print "$total\n";