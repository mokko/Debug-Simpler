#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Debug::Simpler 'debug', 'register_debug';


my $asub = sub {
	my $msg = shift or return;
	print " D: different debug: $msg\n";
};

register_debug($asub);


Debug::Simpler::debug_on();
debug "hallo";
Debug::Simpler::debug_off();
debug "hallo";
Debug::Simpler::debug_on();
debug "hallo";
