use v5.10;
use strict;
use warnings;

### INPUT
my @super_networks = ( $ARGV[0] );
my @sub_networks = ( @ARGV[1..$#ARGV] );

### FUNCTIONS
sub find {
    my $sub_network = shift;
    my $super_network = shift;

    my ($sub_network_address, $sub_network_mask) = split /\//, $sub_network;
    my ($super_network_address, $super_network_mask) = split /\//, $super_network;

    my @sub_network_address = split /\./, $sub_network_address;
    my @super_network_address = split /\./, $super_network_address;

    # fix
    push(@sub_network_address, 0) while $#sub_network_address < 3;
    push(@super_network_address, 0) while $#super_network_address < 3;

    # semi-match
    if ($sub_network_mask >= $super_network_mask) {

        my $matches = 0;
        my $len = int($super_network_mask / 8);
        for (my $i = 0; $i < $len; $i++) {
            if ($super_network_address[$i] == $sub_network_address[$i]) {
                $matches++;
            }
        }

        my $part = ($super_network_mask / 8);
        my $reverse_bit = ($super_network_mask % 8);
        my $bit = (7 - $reverse_bit);
        my $split_range = 2**$bit;
        my $full_range = 2**($bit + 1);

        # match
        if ($matches == $len && $super_network_address[$part] <= $sub_network_address[$part] && $super_network_address[$part] + $full_range - 1 >= $sub_network_address[$part]) {

            for (my $i = $len; $i < 4; $i++) {
                if ($super_network_address[$i] == $sub_network_address[$i]) {
                    $matches++;
                }
            }

            # full match
            if ($matches == 4 && $super_network_mask == $sub_network_mask) { 

                # remove sub_network from sub_networks
                @sub_networks = grep { $_ ne $sub_network } @sub_networks;

                # remove sub_network from super_networks
                $sub_network = join(".", @sub_network_address) . "/" . $sub_network_mask;
                @super_networks = grep { $_ ne $sub_network } @super_networks;

                return 2;
            }

            # delete old address
            @super_networks = grep { $_ ne $super_network } @super_networks;

            # create new addresses
            my $first = $super_network_address[0] . "." . $super_network_address[1] . "." . $super_network_address[2] . "." . $super_network_address[3] . "/" . ($super_network_mask + 1);
            $super_network_address[$part] += $split_range;
            my $second = $super_network_address[0] . "." . $super_network_address[1] . "." . $super_network_address[2] . "." . $super_network_address[3] . "/" . ($super_network_mask + 1); 

            # add new addresses
            push(@super_networks, $first);
            push(@super_networks, $second);

            return 1;
        }
    }
}

### CODE
my @found = ();
while (@sub_networks) {

    my $res = 0;
    foreach my $sub_network (@sub_networks) {
        foreach my $super_network (@super_networks) {
            $res = &find($sub_network, $super_network);

            # leave if match
            last if $res;
        }

        # add found network
        if ($res == 2) {
            push(@found, $sub_network);
        }

        # leave if match
        last if $res;

        # sub_network not found in all super_networks
        @sub_networks = grep { $_ ne $sub_network } @sub_networks;
    }
} 
say "DONE\n";

say "SUPER NETWORKS LEFT:";
say "\n\t" . join("\n\t", @super_networks) . "\n";
say "SUB NETWORKS FOUND:";
say "\n\t" . join("\n\t", @found) . "\n";


