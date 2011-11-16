package Debug::Simpler;
{
  $Debug::Simpler::VERSION = '0.002';
}

# ABSTRACT: Simple debug messages to STDOUT or do it yourself.

#what about warnings? I guess we can do the same for warnings

use strict;
use warnings;
use Carp 'carp';
require Exporter;
our $debug      = 0;                  #default is off
our $debug_func = 'debug_inbuilt';    #default is in-built
our $warn_func  = 'warn';
our @ISA        = qw(Exporter);
our @EXPORT_OK = qw(debug debug_on debug_off register_debug warning);


sub debug { goto &$debug_func }


sub debug_on { $debug = 1; return 1; }


sub debug_off { $debug = 0; return 1; }


sub debug_inbuilt {
	my $msg = shift or return;
	print "$msg\n" if $debug gt 0;
	return 1;
}


sub register_debug {
	my $asub = shift or carp 'Can\'t register this sub';
	if ( ref $asub ne 'CODE' ) {
		carp 'You didn\'t pass code!';
	}
	$debug_func = $asub;
	return 1;
}


sub warning { goto warn }


sub register_warning {
	my $asub = shift or carp 'Can\'t register this sub';
	if ( ref $asub ne 'CODE' ) {
		carp 'You didn\'t pass code!';
	}
	$warn_func = $asub;
	return 1;
}



__END__
=pod

=head1 NAME

Debug::Simpler - Simple debug messages to STDOUT or do it yourself.

=head1 VERSION

version 0.002

=head1 FUNCTIONS

=head2 debug($msg);

Triggers the actual debug function, &debug_inbuilt($msg) as default. Expects 
debug message as string. Further parameters are handed down. Return value
depends on the return value of the actual debug function.

=head2 debug_on();

turns debug messages on. Expects no parameters, returns 1 on success.

=head2 debug_off();

turns debug messages off. Expects no parameters, returns 1 on success.

=head2 debug_inbuilt($msg); 

Outputs $msg to STDOUT, adding a newline. Returns 1 on success and nothing on 
failure.

This is used as the default debug handler.

=head2 register_debug ($asub); 

Register a subroutine for the debug function. 

Returns 1 on success, may carp on error.

=head2 warning $msg;

=head2 register_warning ($asub); 

Register a subroutine for warnings. 

Returns 1 on success, may carp on error.

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
	
	#different way to say the same using a sub reference
	sub asub {return shift}
	register_debug(\&asub)

=head1 SEE ALSO

	Debug::Simple

=head1 AUTHOR

Maurice Mengel <mauricemengel@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Maurice Mengel.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

