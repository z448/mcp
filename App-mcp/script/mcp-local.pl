#!/usr/bin/env perl 
# parsing content of CPAN mirror  (see https://metacpan.org/pod/CPAN::Mini)
#  02packages.details.txt is 16Mb text file listing latest versions of all (~33000) cpan modules
#  minicpan2j.pl takes only unique distribution names into json to decrease size below 1Mb, which is cache limit for WebClip in ios7+ 

use IO::All;
use JSON::XS; #do it fast
use List::MoreUtils qw/ uniq /;
use Term::ANSIColor;
# needs curl from default Telesphoreo repo

qx!rm -rf bin/02packages.details.txt && curl -Lo bin/02packages.details.txt.gz http://www.cpan.org/modules/02packages.details.txt.gz && gunzip bin/02packages.details.txt.gz!; # gunzip -> txt (848K)
my @lines = io('bin/02packages.details.txt')->slurp; # slurp file to array
my (@pkgs, %pkg, $opt);

$opt=$ARGV[0]; 
#$opt=qr/$opt/;

sub splitit { # split lines by whitespace
    for my $line (@lines) {
        @pkg = split(' ', $line );
            my $word = $pkg[2]; #take only last bit
            push @pkgs, $word;
    }
}

sub unique {
    my @unique = uniq @pkgs; #copy unique 
    for (@unique) {
        s/.*\/(.*)\-.*?\.tar\.gz/$1/; $_=$1; #strip leading path, remove suffix
#        s/\-/\ /g; # dash to \s
        $pkg{'t'} = $_;
        push @p, {%pkg}; #hash ref to array
        }
}

sub jay { #to json
    my $p = \@p;
    my $j = encode_json $p;
    $j > io('bin/minicpan.json');
    #print $j;
    srch(\$p);
}
splitit(); unique(); jay();

sub srch {
    if (defined($opt) && ($opt =~ /.*/)) {
            my @match = grep { $_->{'t'} =~ /.?$opt.?/ } @p;
            print `clear`;
            print "meta"; print colored(qq!\ \:\:\ !, q!red on_bright_black!); print "cpan\n";

    for (@match) {
        if ($i % 2) {
            print colored(qq!$_->{'t'}!, q!white on_bright_black!);
        } else {
            print colored(qq!$_->{'t'}!, q!white on_bright_black!);
        }
        #print colored(qq!\ \:\ !, q!white on_bright_black!);
        print colored(qq!\ \:\:\ !, q!red on_bright_black!);
        $i++;
    }
    
    print "\n";
    }
}