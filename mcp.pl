 #!/usr/bin/env perl
# takes -s <module::name> as arg and returns 20 distribution-names that match pattern
# use it before build to find exact dist-name

use Term::ANSIColor;
use HTTP::Tiny;
use JSON;
use Getopt::Std;

die "Usage:\n\n\ mcpq -s <Module::Name>\n\n" unless @ARGV;

getopts('s:', \%opts);

my $pm_req='https://metacpan.org/search/autocomplete?q='."$opts{s}";
my $meta_json =qx!curl -sL $pm_req!;
die "https request failed!\n" unless decode_json $meta_json;

_parse($meta_json);

sub _parse {
    my $j = shift;
    my $pm = decode_json $j;
    my $i==1;

    for my $dist (@$pm) {
        if ($i % 2) {
            print colored(qq!$$dist{'distribution'}!, q!white on_black!);
        } else {
            print colored(qq!$$dist{'distribution'}!, q!white on_black!);
        }
        print colored(qq!\ \:\:\ !, q!red on_black!);
        $i++;
    }
    print "\n";
}