package Test::Program;

use warnings;
use strict;

=head1 NAME

Test::Program - Testing tools for Perl programs

=head1 VERSION

Version 0.04

=cut

our $VERSION = '0.04';

=head1 SYNOPSIS

You've written a command-line program, not just a module, and you want to make sure that
it compiles, runs and has valid POD embedded.

    use Test::More tests => 1;
    use Test::Program;

    my $program = "bin/flooble";

    program_compiles_ok( $program );

    # And coming soon...
    program_pod_ok( $program );
    program_help_ok( $program );
    program_version_ok( $program );

=cut

use base 'Exporter';
use Test::Builder;
my $Test = Test::Builder->new;

=head1 EXPORT

All the C<*_ok> functions are exported by default.

=cut

our @EXPORT_OK = qw(
    program_compiles_ok
    program_pod_ok
);
our @EXPORT = @EXPORT_OK;

=head1 FUNCTIONS

All functions in Test::Program are standard Test::Builder-based functions.
All return true or false depending on whether the test passed or failed.

Unlike most C<Test::>, none of these functions takes a parameter for
the description of the test.  Each of the fucntions generates its own
automatically.

For the functions that execute a program, rather than just checking POD
statically, the function will also use the command-line options on the
shebang line.

=head2 program_compiles_ok( $program )

Checks to see that I<$program> compiles under C<perl -cw>.

=cut

sub program_compiles_ok {
    my $program = shift;

    my $switches = shebang_switches( $program );

    # run program with $switches
    my $command_line = "$^X $switches -w -c $program 2>&1";
    my @output = `$command_line`;

    my ($exit,$sig) = ($? >> 8, $? & 127);

    my $msg = "$program compiles";
    if ( $exit ) {
        $Test->ok( 0, $msg );
        $Test->diag( @output );
        $Test->diag( "Returned error code $exit" );
        return;
    }

    my $ok = ( (@output == 1) && ($output[0] eq "$program syntax OK\n" ) );
    $Test->ok( $ok, $msg );
    if ( !$ok ) {
        $Test->diag( "Warnings:" );
        $Test->diag( @output );
    }

    return $ok;
}

=head2 program_pod_ok( $program )

Checks to see that I<$program> has valid POD.

=cut

sub program_pod_ok {
    my $program = shift;

    require Test::Pod;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    return Test::Pod::pod_file_ok( $program, "$program POD OK" );
}


=head1 PRIVATE FUNCTIONS

=head2 shebang_switches( $program )

Returns a string representing the switches passed on the shebang line
in the program.

=cut

sub shebang_switches {
    my $program = shift;

    open( my $fh, "<", $program ) or die "Can't open $program for reading: $!\n";
    my $line = <$fh>;
    close $fh;

    chomp $line;

    return ( $line =~ /#!\S*perl\s+(.+)/ ? $1 : '' );
}


=head1 AUTHOR

Andy Lester, C<< <andy at petdance.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-test-program at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Program>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Program

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Program>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Program>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Program>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Program>

=back

=head1 ACKNOWLEDGEMENTS

Thanks to Matt Liggett for the original idea and push to do it.

=head1 COPYRIGHT & LICENSE

Copyright 2006 Andy Lester, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Test::Program
