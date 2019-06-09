use v5.10;
use strict;
use warnings;

### READ
$/ = undef;
open(FILE, "<", "./files/customer.xml") or die "Cannot open file...";
chomp(my $file = <FILE>);
close(FILE);

### DATA STRUCTURE
my $total = 0;
my %segments = ();

### PROCESS
while ($file =~ m/<T>(?<content>.*?<\/T>)/gsmc) {
    my $segment;
    my $name;
    my $element = $+{content};

    if ($element =~ m/<C_MKTSEGMENT>(?<segment>.*?)<\/C_MKTSEGMENT>/) {
        $segment = lc($+{segment});
    }

    if ($element =~ m/<C_NAME>(?<name>.*?)<\/C_NAME>/) {
        $name = $+{name};
    }

    $total++;
    $segments{$segment}->[0]++;
    push( @{$segments{$segment}->[1]}, $name);
}
say "There are ", $total, " customers: \n";

### PERCENTAGES
my @headers = ();
my $maximum = 0;
foreach my $segment (sort keys %segments) {
    my $percentage = sprintf("%.1f", $segments{$segment}->[0] / $total * 100);
    
    $maximum = $segments{$segment}->[0] if ($segments{$segment}->[0] > $maximum);

    push(@headers, sprintf("%-25s", "[ " . $percentage . "% " . $segment . " ]"));
}
say "\t" . join(" " x 10, @headers);
say "";

# LIST
for (my $i = 0; $i < $maximum; $i++) {
    
    my @row = ();
    foreach my $segment (sort keys %segments) {
        if ($segments{$segment}->[0] > $i) {
            push(@row, sprintf("%-25s", $segments{$segment}->[1]->[$i]));
        }
        else {
            push(@row, sprintf("%-25s", " "));
        }
    }
    say "\t" . join(" " x 10, @row);
}

