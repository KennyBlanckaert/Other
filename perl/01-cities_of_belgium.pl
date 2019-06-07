use v5.10;
use strict;
use warnings;

# FUNCTIONS
sub find_parent {
    my $record = shift;
    my $parent = shift;

    if ($record->[0] eq $parent) {
        return $record;
    }
    else {
        foreach my $child ( @{$record->[2]} ) {
            my $result = &find_parent($child, $parent);

            if ($result) {
                return $result;
            }
        }
    }

    return 0;
}

sub count_pop {
    my $record = shift;

    my $sum = $record->[3];
    foreach my $child ( @{$record->[2]} ) {
        $sum += &count_pop($child);
    }
    $record->[3] = $sum;

    return $sum;
}

sub count_area {
    my $record = shift;

    my $sum = $record->[4];
    foreach my $child ( @{$record->[2]} ) {
        $sum += &count_area($child);
    }
    $record->[4] = $sum;

    return $sum;
}

sub print_out {
    my $record = shift;
    my $indentation = shift;

    print "\t" x $indentation;
    say $record->[0], "(pop: ", $record->[3], ", area: ", $record->[4], ")";

    foreach my $child ( @{$record->[2]} ) {
        &print_out($child, $indentation + 1);
    }
}


# READ FILE
open(FILE, "<", "files/cities.csv") or die("Cannot open file...");
chomp( my @lines = <FILE> );
close(FILE);

# STORAGE
my $belgium = [];
foreach my $line (@lines) {
    my ($name, $parent, $population, $area) = split /;/, $line;
    
    if (!@{$belgium}) {

        $belgium->[0] = $name;
        $belgium->[1] = $parent;
        $belgium->[2] = [];
        $belgium->[3] = $population || 0;
        $belgium->[4] = $area || 0;

    }
    else {

        my $record = [];
        $record->[0] = $name;
        $record->[1] = $parent;
        $record->[2] = [];
        $record->[3] = $population || 0;
        $record->[4] = $area || 0;

        my $parent_record = &find_parent($belgium, $parent);
        push( @{$parent_record->[2]}, $record );

    }
}

# FINALIZE
&count_pop($belgium);
&count_area($belgium);

# PRINT
&print_out($belgium, 0);
