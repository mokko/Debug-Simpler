#!perl

#i remove -T to use FindBin
use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More tests => 1;

BEGIN {
    use_ok( 'Debug::Simpler' ) || print "Bail out!";
}

diag( "Testing Debug::Simpler $Debug::Simpler::VERSION, Perl $], $^X" );
