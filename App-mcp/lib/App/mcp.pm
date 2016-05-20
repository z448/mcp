package App::mcp;

use 5.006;
use strict;
use warnings;

use Term::ANSIColor;
use HTTP::Tiny;
use JSON;
use Getopt::Std;

die "Usage:\n\n\ mcpq -s <Module::Name>\n\n" unless @ARGV;

getopts('s:', \%opts);

my $pm_req='https://metacpan.org/search/autocomplete?q='."$opts{s}";
my $meta_json =qx!curl -sL $pm_req!;
die "https request failed!\n" unless decode_json $meta_json;


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

=HEAD1 NAME

=over 12

=item mcp

=item Meta Cpan Query

=back

=HEAD1 SYNOPSIS

=over 12

=item Search Metacpan for module names

=back

=HEAD1 EXAMPLES

=over 12

=item C<mcp git>

=back

=cut


=head1 NAME

App::mcp - The great new App::mcp!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use App::mcp;

    my $foo = App::mcp->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

z448, C<< <zed448 at icloud.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-mcp at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-mcp>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::mcp


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-mcp>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-mcp>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-mcp>

=item * Search CPAN

L<http://search.cpan.org/dist/App-mcp/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016 z448.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of App::mcp
