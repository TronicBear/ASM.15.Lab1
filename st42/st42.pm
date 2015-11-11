#!/usr/bin/env perl
package st42;
use 5.010;
use strict;
use warnings;

sub st42
{
	print "st42:st42\n";
	my $menu = "		Card file\n
			** Select necessery number **\n
			1. Add element;\n
			2. Edit element;\n
			3. Delete element;\n
			4. Show list;\n
			5. Save list to file;\n
			6. Download list from file;\n
			7. Exit.\n";		

	my @card_file = ();
	my @functions = (\&add, \&edit, \&delete, \&show, \&save, \&download);
	my %hdb = ();
	ANCHOR:
	while(1){
		print "$menu";
		my $snum = <STDIN>;
		chomp $snum;
		if($snum == 1)
			{
				$functions[0]->();
			}
			if($snum == 2){
				$functions[1]->();
			}
			if($snum == 3){
				$functions[2]->();
			}
			if($snum == 4){
				$functions[3]->();
			}
			if($snum == 5){
				$functions[4]->();
			}
			if($snum == 6){
				$functions[5]->();
			}
			if($snum == 7){
				last ANCHOR;
			}
			default {print "Invalid number!!!\n";}
		
	}

	sub add{
		my($name, $surname, $group, $href);
		print "Enter name: "; $name = <STDIN>; chomp $name;
		print "Enter surname: "; $surname = <STDIN>; chomp $surname;
		print "Enter group: "; $group = <STDIN>; chomp $group;
		$href = {
				"name",   $name,
				"surname",$surname,
				"group",  $group
				};
		push(@card_file, $href);
		return 1;
	}

	sub edit{
		my $num;
		print "\tThere are ".($#card_file + 1)." elements in card file.\n
		Please select number of element which you would like to edit: ";
		$num = <STDIN>; chomp $num;
		if($num < 1 || $num > ($#card_file + 1)){
			return 0;
		}
		while((my $key, my $value) = each(%{$card_file[$num-1]})){
			print "\n\t\tCurrent $key:	".${$card_file[$num-1]}{$key}."\n
			Enter $key: "; 
			$value = <STDIN>; chomp $value;
			if($value ne ""){
				${$card_file[$num-1]}{$key} = $value;
			}
		}
		return 1;
	}

	sub delete{
		my $num;
		print "\tThere are ".($#card_file + 1)." elements in card file.\n
		Please select number of element whic you would like to delete: ";
		$num = <STDIN>; chomp $num;
		if($num < 1 || $num > ($#card_file + 1)){
			return 0;
		}
		splice(@card_file,$num-1,1);
		return 1;
	}

	sub show{
		for(my $i = 0; $i < ($#card_file + 1); $i++){
			print "person ".($i+1)."\n";
			while((my $key, my $value) = each(%{$card_file[$i]})){
				print "	$key: $value\n";
			}
		}
		return 1;
	}

	sub save{
		dbmopen(%hdb, "dbfile", 0666) || die "can't open DBM file!\n";
		my $s; %hdb = ();
		for(my $i = 0; $i < ($#card_file + 1); $i++){
			$s = join("::",${$card_file[$i]}{"name"},
						   ${$card_file[$i]}{"surname"},
						   ${$card_file[$i]}{"group"});
			$hdb{"el".$i} = $s;
		}
		dbmclose(%hdb);
		return 1;
	}

	sub download{
		my ($name,$surname,$group,$href);
		@card_file = ();
		dbmopen(%hdb, "dbfile", 0666) || die "can't open DBM file!\n";
		while((my $key, my $value) = each(%hdb)){
			($name,$surname,$group) = split(/::/,$value);
			$href = {
					"name",   $name,
					"surname",$surname,
					"group",  $group
					};
			push(@card_file, $href);
		}
		dbmclose(%hdb);
		return 1;
	}
}
return 1;
