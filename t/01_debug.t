#!perl
use strict;
use warnings;
use Test::More tests => 8;

#i remove -T to use FindBin
use FindBin;
use lib "$FindBin::Bin/../lib";
use Debug::Simpler 'debug', 'register_debug';

Debug::Simpler::debug_on();
ok( $Debug::Simpler::debug == 1, 'debug_on internal' );

{
	my $ret = Debug::Simpler::debug_on();
	ok( $ret == 1, 'debug_on return value' );
}

Debug::Simpler::debug_off();
ok( $Debug::Simpler::debug == 0, 'debug_off internal' );

{
	my $ret = Debug::Simpler::debug_off();
	ok( $ret == 1, 'debug_off return value' );
}


my $asub = sub {
	my $msg = shift or return;
	return $msg;
};

#different way to say the same?
sub asub { return shift; }

ok( register_debug($asub) == 1, 'register_debug' );
ok( debug ('bla') eq 'bla', 'test registered debug');

ok( register_debug(\&asub) == 1, 'register_debug' );
ok( debug ('bla') eq 'bla', 'test registered debug');



#how do i test if something writes to STDOUT?
