use v5.10;
use strict;
use warnings;

### CONSTANTS
my @positions = ("K", "W", "B", "M", "F", "S");

### READ
open(FILE, "<", "./input/footballers.csv");
chomp(my @lines = <FILE>);
close(FILE);

### PROCESS
my %players = ();
my %clubs = ();
foreach my $line (@lines) {
    my @records = split /,/, $line;

    my $name = $records[2];
    my $photo = $records[4];            # Unused
    my $nationality = $records[5];      # Unused
    my $club = $records[9];
    my $club_logo = $records[10];
    my $position = $records[21];

    $clubs{$club} = $club_logo;
    push( @{$players{$club}}, [ $name, $nationality, $photo, $position ]);
}

### COMBINE
my @records = ();
foreach my $club (sort { $a cmp $b } keys %clubs) {
    
    # club, club_logo, total_players
    my $club_logo = $clubs{$club};
    my $total_players = @{$players{$club}};

    # players / position
    my %players_per_position = map { $_ => [] } @positions;
    foreach my $player (@{$players{$club}}) {
        
        my $name = $player->[0];
        my $nationality = $player->[1];
        my $photo = $player->[2];
        my $position = $player->[3];

        $total_players-- && next if (!$position);

        my $position_length = length($position);
        my $last_letter = substr($position, $position_length - 1, 1);
        
        $total_players-- && next if ($last_letter eq "T" || $last_letter eq "n" );

        push( @{$players_per_position{$last_letter}}, "<a href=\"$photo\">$name</a>");
    }

    my @players_per_position = map { $players_per_position{$_} } @positions;
    push(@records, [ $club, $club_logo, $total_players, @players_per_position ]);
}

### TABLE
my $table = "<TR> <TH>Club<\/TH> <TH>#.Players<\/TH> <TH>Keepers<\/TH> <TH>Wingmans<\/TH> <TH>Backs<\/TH> <TH>Midfielders<\/TH> <TH>Forwarder<\/TH> <TH>Striker<\/TH> <\/TR>";
for (my $i = 1; $i < @records; $i++) {
    my $record = $records[$i];
    $table .=   "<TR>" .
                    "<TH><a href=\"" . $record->[1] . "\">" . $record->[0] . "</a></TH>" .
                    "<TH>" . $record->[2] . "</TH>" .

                    "<TH>" . join("<BR>", @{$record->[3]}) . "</TH>" .
                    "<TH>" . join("<BR>", @{$record->[4]}) . "</TH>" .
                    "<TH>" . join("<BR>", @{$record->[5]}) . "</TH>" .
                    "<TH>" . join("<BR>", @{$record->[6]}) . "</TH>" .
                    "<TH>" . join("<BR>", @{$record->[7]}) . "</TH>" . 
                    "<TH>" . join("<BR>", @{$record->[8]}) . "</TH>" .
                "</TR<>"
}

### HTML
my $html = <<"CONTENT";
<HTML>
  	<BODY>
    	<TABLE border=1 cellspacing=0 cellpadding=0>
      		$table
    	</TABLE>
  	</BODY>
</HTML>
CONTENT

### SAVE
open(OUTPUT, ">", "./output/clubs.html");
say OUTPUT $html;
close(OUTPUT);