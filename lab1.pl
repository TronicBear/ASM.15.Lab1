#!/usr/bin/perl

use strict;

use st00::st00;
use st01::st01;
use st02::st02;
use st03::st03;
use st04::st04;
use st06::st06;
use st07::st07;
use st08::st08;
use st09::st09;
use st11::st11;
use st12::st12;
use st13::st13;
use st14::st14;
use st15::st15;
use st17::st17;
use st18::st18;
use st19::st19;
use st21::st21;
use st22::st22;
use st24::st24;
use st26::st26;
use st27::st27;
use st28::st28;
use st29::st29;
use st30::st30;
use st31::st31;
use st32::st32;
use st33::st33;
use st36::st36;
use st37::st37;
use st38::st38;
use st39::st39;
use st42::st42;
use st43::st43;
use st45::st45;
use st46::st46;
use st47::st47;
use st34::st34;


my @MODULES =
(
	\&ST00::st00,
	\&ST01::st01,
	\&ST02::st02,
	\&ST03::st03,
	\&ST04::st04,
	\&ST06::st06,
	\&ST07::st07,	
	\&ST08::st08,
	\&ST09::st09,
	\&ST11::st11,
	\&ST12::st12,
	\&ST13::st13,
	\&ST14::st14,
	\&ST15::st15,
	\&ST17::st17,
	\&ST18::st18,
	\&ST19::st19,
	\&ST21::st21,
	\&ST22::st22,
	\&ST24::st24,
	\&ST26::st26,
	\&ST27::st27,
	\&ST28::st28,
	\&ST29::st29,
	\&ST30::st30,
	\&ST31::st31,
	\&ST32::st32,
	\&ST33::st33,
	\&ST36::st36,
	\&ST37::st37,
	\&ST38::st38,
	\&ST39::st39,
	\&ST42::st42,
	\&ST43::st43,
	\&ST45::st45,
	\&ST46::st46,	
	\&ST47::st47,
	\&ST34::st34,


	
);

my @NAMES =
(
	"00. Sample",
	"01. Baglikova",
	"02. Badrudinova",
	"03. Baranov",
	"04. Borisenko",
	"06. Goncharov",
	"07. Gorinov",
	"08. Gracheva",
	"09. Greznev",
	"11. Drojjin",
	"12. Zheleznev",.
	"13. Zlotnikov",
	"14. Ivanova",
	"15. Ionov",
	"17. Kirichenko",
	"18. Klykov",
	"19. Konstantinova",
	"21. Larionov",
	"22. Lomakina",
	"24. Mamedov",
	"26. Mikaelian",
	"27. Nikishaev",
	"28. Nikolaeva",
	"29. Novozhentsev",
	"30. Pereverzev",
	"31. Podkolzin",
	"32. Pyatakhina",
	"33. Rekhlova",
	"36. Skripacheva",
	"37. Stankevich",
	"38. Stepenko",
	"39. Stupin",
	"42. Umnikov",
	"43. Frolov",
	"45. Yazkov",
	"46. Bushmakin",
	"47. Utenov",
	"48. Rozhok",
	
);

sub menu
{
	my $i = 0;
	print "\n------------------------------\n";
	foreach my $s(@NAMES)
	{
		print "$i. $s\n";
		$i++;
	}
	print "------------------------------\n";
	my $ch = <STDIN>;
	return ($ch);
}

while(1)
{
	my $ch = menu();
	if(defined $MODULES[$ch])
	{
		print $NAMES[$ch]." launching...\n\n";
		$MODULES[$ch]->();
	}
	else
	{
		exit();
	}
}
