#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use Getopt::Long;

use lib "$FindBin::Bin/lib";
use Template::Tiny;


my %APP = (
    dzil => [qw/dzil/],
    gem  => [qw/gemrc/],
    git  => [qw/gitconfig/],
    vim  => [qw/vim vimrc/],
);


my $context = 'home';
my %var = (
    email => 'uwe@uwevoelker.de',
);
my $result  = GetOptions(
    'context=s' => \$context,
    'email=s'   => \$var{email},
);
# set context
$var{context} = {$context => 1};


unless (@ARGV) {
    print "The following apps are available:\n";
    foreach my $app (sort keys %APP) {
        print "$app\n";
    }
    exit 1;
}


my $tt = Template::Tiny->new;

foreach my $name (@ARGV) {
    unless (exists $APP{$name}) {
        print "Unknown app '$name'\n";
        next;
    }
    my $files = $APP{$name};
    foreach my $file (@$files) {
        my $path = "$FindBin::Bin/$file";
        if (-f "$path.tt") {
            my $template;
            {
                local $/;
                open(my $fh, '<', "$path.tt") or die "$file.tt: $!";
                $template = <$fh>;
                close $fh or die "$file.tt: $!";
            }
            my $out;
            $tt->process(\$template, \%var, \$out);
            my $out_path = "$ENV{HOME}/.$file";
            open(my $fh, '>', $out_path) or die "$out_path: $!";
            print $fh $out               or die "$out_path: $!";
            close $fh                    or die "$out_path: $!";
        }
        else {
            system "rm -rf ~/.$file\n";
            system "ln -s $FindBin::Bin/$file ~/.$file\n";
        }
    }
}

