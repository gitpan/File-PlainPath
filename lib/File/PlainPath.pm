use strict;
use warnings;
package File::PlainPath;

# ABSTRACT: Construct portable filesystem paths in a simple way

use File::Spec;


require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(path to_path);

# Mapping between package names and regular expressions that match directory
# separators
my %separator_re;


sub path {
    my @paths = @_;
    my @path_components = map { split($separator_re{caller()} ||= '/', $_) }
        @paths;
    return File::Spec->catfile(@path_components);
}


*to_path = *path;


sub set_separator {
    my $separator = quotemeta(shift);
    $separator_re{caller()} = qr{$separator};
}


1;

__END__
=pod

=head1 NAME

File::PlainPath - Construct portable filesystem paths in a simple way

=head1 VERSION

version 0.02

=head1 SYNOPSIS

    use File::PlainPath qw(path);
    
    # Forward slash is the default directory separator
    my $path = path 'dir/subdir/file.txt';
    
    # Set backslash as directory separator
    File::PlainPath::set_separator('\\');   
    my $other_path = path 'dir\\other_dir\\other_file.txt';

=head1 DESCRIPTION

File::PlainPath translates filesystem paths that use a common directory
separator to OS-specific paths. It allows you to replace constructs like this:

    my $path = File::Spec->catfile('dir', 'subdir', 'file.txt');

with a simpler notation:

    my $path = path 'dir/subdir/file.txt';

The default directory separator used in paths is the forward slash (C</>), but
any other character can be designated as the separator:

    File::PlainPath::set_separator(':');
    my $path = path 'dir:subdir:file.txt';

=head1 FUNCTIONS

=head2 path

Translates the provided path to OS-specific format. If more than one path is
specified, the paths are concatenated to produce the resulting path. 

Examples:

    my $path = path 'dir/file.txt';

    my $path = path 'dir', 'subdir/file.txt';
    # On Unix, this produces: "dir/subdir/file.txt" 

=head2 to_path

An alias for L</path>. Use it when there's another module that exports a
subroutine named C<path> (such as L<File::Spec::Functions>).

Example:

    use File::PlainPath qw(to_path);
    
    my $path = to_path 'dir/file.txt';

=head2 set_separator

Sets the character to be used as directory separator.

Example:

    File::PlainPath::set_separator(':');

=head1 SEE ALSO

=over 4

=item * L<File::Spec>

=back

=head1 AUTHOR

Michal Wojciechowski <odyniec@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Michal Wojciechowski.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

