use v5.10;
use strict;
use warnings;

### FUNCTIONS
sub key_component_one {
    my $rank = shift;

    my $x = 0;
    $x++ while (2**$x < $rank);

    return $x;
}

sub key_component_two {
    return rand(100);
}

### READ
chomp(my @lines = <DATA>);

### STORAGE
my $rank = 1;
my $ranking = []; 
foreach my $line (@lines) {
    if ($line =~ m/^(.*) \((\w+)\)$/) {
        push(@{$ranking}, [$rank++, $1, $2]);
    }
}

### REORDER
my $number = 1;
my $new_ranking = {};
foreach my $player (sort { key_component_one($a->[0]) <=> key_component_one($b->[0]) || key_component_two($a->[0]) <=> key_component_two($b->[0]) } @{$ranking}) {
    $new_ranking->{$number} = $player;
    $number++;
}

### PRINT
my $row_length = 64;
foreach my $line (@lines) {

    # matches
    if ($line =~ m/^(\d+) \s* (\d+)$/) {
        my $player = $new_ranking->{$1}->[1] . " (" . $new_ranking->{$1}->[2] . ", " . $new_ranking->{$1}->[0] . ")";
        my $opponent = $new_ranking->{$2}->[1] . " (" . $new_ranking->{$2}->[2] . ")";
        
        my $player_length = length($player);
        my $opponent_length = length($opponent);

        my $indentation = $row_length - $player_length - $opponent_length;

        print "$player", " " x $indentation ,"$opponent\n";
    }

    # group
    if ($line =~ m/[-]{$row_length}/) {
        print "$line\n";
    }
}


__DATA__
Roger Federer (SUI)
Rafael Nadal (ESP)
Novak Djokovic (SRB)
Andy Murray (GBR)
Juan Martin Del Potro (ARG)
Nikolay Davydenko (RUS)
Andy Roddick (USA)
Jo-Wilfried Tsonga (FRA)
Fernando Verdasco (ESP)
Robin Soderling (SWE)
Fernando Gonzalez (CHI)
Gilles Simon (FRA)
Marin Cilic (CRO)
Radek Stepanek (CZE)
Gael Monfils (FRA)
Tommy Robredo (ESP)
Tommy Haas (GER)
David Ferrer (ESP)
Tomas Berdych (CZE)
Lleyton Hewitt (AUS)
Stanislas Wawrinka (SUI)
Juan Carlos Ferrero (ESP)
James Blake (USA)
Philipp Kohlschreiber (GER)
Mikhail Youzhny (RUS)
Sam Querrey (USA)
David Nalbandian (ARG)
Nicolas Almagro (ESP)
Ivan Ljubicic (CRO)
Juan Monaco (ARG)
Viktor Troicki (SRB)
Jeremy Chardy (FRA)
Paul-Henri Mathieu (FRA)
Andreas Beck (GER)
Jurgen Melzer (AUT)
Albert Montanes (ESP)
Victor Hanescu (ROU)
Igor Andreev (RUS)
John Isner (USA)
Ivo Karlovic (CRO)
Marcos Baghdatis (CYP)
Dudi Sela (ISR)
Thomaz Bellucci (BRA)
Benjamin Becker (GER)
Feliciano Lopez (ESP)
Janko Tipsarevic (SRB)
Guillermo Garcia-Lopez (ESP)
Jose Acasuso (ARG)
Pablo Cuevas (URU)
Evgeny Korolev (RUS)
Julien Benneteau (FRA)
Andreas Seppi (ITA)
Fabrice Santoro (FRA)
Horacio Zeballos (ARG)
Daniel Koellerer (AUT)
Fabio Fognini (ITA)
Mardy Fish (USA)
Dmitry Tursunov (RUS)
Simon Greul (GER)
Maximo Gonzalez (ARG)
Jan Hernych (CZE)
Olivier Rochus (BEL)
Marc Gicquel (FRA)
Martin Vassallo Arguello (ARG)
1                                                             64
32                                                            33
17                                                            48
16                                                            49

9                                                             56
24                                                            41
25                                                            40
8                                                             57
----------------------------------------------------------------
5                                                             60
28                                                            37
21                                                            44
12                                                            53

13                                                            52
20                                                            45
29                                                            36
4                                                             61
----------------------------------------------------------------
3                                                             62
30                                                            35
19                                                            46
14                                                            51

11                                                            54
22                                                            43
27                                                            38
6                                                             59
----------------------------------------------------------------
7                                                             58
26                                                            39
23                                                            42
10                                                            55

15                                                            50
18                                                            47
31                                                            34
2                                                             63
