package Debug::Simpler;
{
  $Debug::Simpler::VERSION = '0.001';
}
# ABSTRACT: Debug messages. 
#what about warning?

use strict;
use warnings;
use Carp 'carp';
require Exporter;
our $debug      = 0;                  #default is off
our $debug_func = 'debug_inbuilt';    #default is in-built
our @ISA        = qw(Exporter);
our @EXPORT_OK = qw(debug debug_on debug_off register_debug);


sub debug     { goto &$debug_func }
sub debug_on  { $debug = 1 }
sub debug_off { $debug = 0 }

sub debug_inbuilt {
	my $msg = shift or return;
	print "$msg\n" if $debug gt 0;
}

sub register_debug {
	my $asub = shift or carp 'Can\'t register this sub';
	if ( ref $asub ne 'CODE' ) {
		carp 'You didn\'t pass code!';
	}
	$debug_func = $asub;
}

__END__
=pod

=head1 NAME

Debug::Simpler - Debug messages. 

=head1 VERSION

version 0.001

=head2 SYNOPSIS

	#inbuilt debug (to STDOUT)
	use Simple::Messages 'debug';
	Simple::Messages::debug_on;
	debug 'my pretty debug message';
	
	#DIY - build your own
	use Simple::Messages 'debug', 'register_debug', 'debug_on';
	debug_on;

	my $asub=sub {
		my $msg=shift or return;
		print " D: different debug: $msg\n";
	};

	register_debug ($asub);
	debug 'my pretty debug message';

=head2 SEE ALSO
	Debug::Simple

=head1 AUTHOR

Maurice Mengel <mauricemengel@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Maurice Mengel.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

