use v5.10;
# use strict;
# use warnings;

### SETTINGS
my $found = 0;
my $print = 0;

### FUNCTIONS
sub convert_installs {
    my $var = shift;

    my $removed_plus = substr($var, 0, length($var) - 1);
    my $number = 0 + join("", split /,/, $removed_plus);

    return $number;
}

### READ
open(FILE, "<", "./input/googleplaystore.csv");
chomp(my @lines = <FILE>);
close(FILE);

### MAKE DATA STRUCTURE
my @columns = split /,/, $lines[0];
my $len = @columns;

my $found = 0;
my %apps = ();
for (my $i = 1; $i <= $#lines; $i++) {
    my $line = $lines[$i];

    if ($line =~ m/"?(.*)"?,([A-Z_]+),(.*?),(.*?),(.*?),"(.*)",(.*?),(.*?),(.*?),(.*?),"(.*?)",(.*?),(.*)/) {
        $apps{$1}->{$columns[1]} = $2;
        $apps{$1}->{$columns[2]} = $3;
        $apps{$1}->{$columns[3]} = $4;
        $apps{$1}->{$columns[4]} = $5;
        $apps{$1}->{$columns[5]} = $6;
        $apps{$1}->{$columns[6]} = $7;
        $apps{$1}->{$columns[7]} = $8;
        $apps{$1}->{$columns[8]} = $9;
        $apps{$1}->{$columns[9]} = $10;
        $apps{$1}->{$columns[10]} = $11;
        $apps{$1}->{$columns[11]} = $12;
        $apps{$1}->{$columns[12]} = $13;

        $found++;
    }
}

### PRINT
if ($print) {
    say $found;
    say "";

    foreach my $app_name (sort keys %apps) {
        say $app_name;

        my $app = $apps{$app_name};
        foreach my $column (sort keys %{$app}) {
            say "\t", $column, " => ", $app->{$column};
        }
    }
}

### SORT BY RATING | TOP 100
my $rank = 1;
foreach my $app (sort { &convert_installs($apps{$b}->{"Installs"}) <=> &convert_installs($apps{$a}->{"Installs"}) || $apps{$b}->{"Rating"} <=> $apps{$a}->{"Rating"} } keys %apps) {
    say "[", $rank, "] ", $app, "\n\t\t", sprintf("%s", "(Installs: " . $apps{$app}->{"Installs"} . ", Rating: " . $apps{$app}->{"Rating"}  . ")\n");
    $rank++;

    last if ($rank > 100)
}




