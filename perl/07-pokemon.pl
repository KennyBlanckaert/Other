use v5.10;
# use strict;
# use warnings;

### TYPES & COLORS
my @types = ("Water", "Grass", "Fire", "Normal", "Fighting", "Ground", "Rock", "Steel",
    "Flying", "Dark", "Ghost", "Electric", "Dragon", "Bug", "Ice", "Poison", "Psychic", "Fairy", 
    "Legendary"
);

my @colors = ("aqua", "springgreen", "darkorange", "lightyellow", "maroon", "darkgoldenrod", "rosybrown",
    "silver", "lightskyblue", "darkslateblue", "rebeccapurple", "khaki", "midnightblue", "darkkhaki",
    "powderblue", "darkmagenta", "plum", "thistle", "pink"
);

### FILES
my @filenames = ("pokemon_first_generation.csv", "pokemon_second_generation.csv", "pokemon_third_generation.csv", "pokemon_fourth_generation.csv");

### TABLES
my @tables = ();
foreach my $filename (@filenames) {

    ### READ
    open(FILE, "<", "./input/${filename}") or die "Cannot open file...";
    chomp(my @lines = <FILE>);
    close(FILE);

    ### STORAGE
    my %pokemon_per_type = map { $_ => [] } @types;

    for (my $i = 1; $i <= $#lines; $i++) {
        my $line = $lines[$i];
        my ($num, $name, $type1, $type2, undef, undef, undef, undef, undef, undef, undef, undef, $legendary) = split /,/, $line;

        # legendary
        if ($legendary eq "True") {
            push(@{$pokemon_per_type{"Legendary"}}, $name);
            next;
        }

        # first type
        if ($type1) {
            push(@{$pokemon_per_type{$type1}}, $name);
        }

        # second type
        if ($type2) {
            push(@{$pokemon_per_type{$type2}}, $name);
        }
    }

    ### MAX
    my $max = 0;
    foreach my $type (keys %pokemon_per_type) {

        my $size = @{$pokemon_per_type{$type}};
        $max = $size if ($size > $max);
    }

    ### RECORDS
    my @records = ();
    my @empty_row = (" ") x 19; 
    push(@records, \@types);
    push(@records, \@empty_row);
    push(@records, \@empty_row);
    for (my $i = 0; $i < $max; $i++) {

        my @row = ();
        foreach my $type (@types) {
            push(@row, $pokemon_per_type{$type}->[$i]);
        }

        push(@records, \@row);
    }

    ### TABLE
    my $table = "";
    foreach my $record (@records) {
        
        my $headers = "";
        my $color_number = 0;
        foreach my $element (@{$record}){
            $headers .= "<TH style=\"background-color: " . $colors[$color_number] . "; width: 100px; \">" . $element . "<TH>";
            $color_number++;
        }

        $table .= "<TR>" . $headers . "<TR>";
    }

    push(@tables, $table);

}

### HTML
my $html = <<"CONTENT";
<HTML>
  	<BODY>
        <h1>First generation</h2>
    	<TABLE border=1 cellspacing=0 cellpadding=0>
      		$tables[0]
    	</TABLE>
        <BR><BR><BR>
        <h1>Second generation</h2>
        <TABLE border=1 cellspacing=0 cellpadding=0>
      		$tables[1]
    	</TABLE>
        <BR><BR><BR>
        <h1>Third generation</h2>
        <TABLE border=1 cellspacing=0 cellpadding=0>
      		$tables[2]
    	</TABLE>
        <BR><BR><BR>
        <h1>Fourth generation</h2>
        <TABLE border=1 cellspacing=0 cellpadding=0>
      		$tables[3]
    	</TABLE>
  	</BODY>
</HTML>
CONTENT

### SAVE
open(OUTPUT, ">", "./output/pokemon_tables.html");
say OUTPUT $html;
close(OUTPUT);


