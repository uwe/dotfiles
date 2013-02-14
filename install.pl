#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;


my %APP = (
    dzil => [qw/dzil/],
    git  => [qw/gitconfig/],
    vim  => [qw/vim vimrc/],
);


unless (@ARGV) {
    print "The following apps are available:\n";
    foreach my $app (sort keys %APP) {
        print "$app\n";
    }
    exit 1;
}

foreach my $name (@ARGV) {
    unless (exists $APP{$name}) {
        print "Unknown app '$name'\n";
        next;
    }
    my $files = $APP{$name};
    foreach my $file (@$files) {
        system "rm -rf ~/.$file\n";
        system "ln -s $FindBin::Bin/$file ~/.$file\n";
    }
}

