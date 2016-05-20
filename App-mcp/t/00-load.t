#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'App::mcp' ) || print "Bail out!\n";
}

diag( "Testing App::mcp $App::mcp::VERSION, Perl $], $^X" );
