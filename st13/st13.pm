#!/usr/bin/perl

package ST13;

use strict;

my @spisok;

sub show {
    if( $#spisok != -1){
        my $i = 0;
            if ($_[0] == 1) {
                foreach my $pers (@spisok) {
                    print ++$i.") Name - ".$pers->{name}."; Age = ".$pers->{age}."\n";
                }
            }
            else{
                foreach my $pers (@spisok) {
                    print "Name - ".$pers->{name}."; Age = ".$pers->{age}."\n";
                }
            }
            return 1
    }
    else{
        print "There is nobody in the list\n";
        return 0
    }
};
 
sub check_name {
    my $str;
    if ($_[0]) {
        $str = "Edit the Name (".$_[0].") = ";
    }
    else{
        $str = "Enter the Name = ";
    }
    print  $str;
    my $name = <STDIN>;
    chomp($name);
    while($name =~ /[^a-zA-Z]/ || length($name) == 0){
        print "Name have to be in the literal form\n". $str;
        $name = <STDIN>;
        chomp($name);
    }
    return $name
};
 
sub check_age {
    my $str;
    if ($_[0]) {
        $str = "Edit Age (".$_[0].") = ";
    }
    else{
        $str = "Enter Age = ";
    }
    print  $str;
    my $age = <STDIN>;
    chomp($age);
    while($age =~ /\D/ || $age == ""){
        print "Age have to be in the digital form\n".$str;
        $age = <STDIN>;
        chomp($age);    
    }
    return $age
};

sub get_num {
    my $length = $#spisok;
    $length++;
    if($length == 1){
        return 1
    }
    else{
        print "Choose the number of record = ";
        my $choice = <STDIN>;
        chomp($choice);
        while($choice > $length || $choice =~ /\D/ || $choice == ""){
            print "Repeat your choice.\nChoose the number of the record = ";
            $choice = <STDIN>;
            chomp($choice);
        }
        return $choice
    }
}
 
my %arr_fun = (
    1 => sub {
        my %spi = (
            name => &check_name(),
            age => &check_age(),
            );
        push(@spisok, \%spi);
    },
    2 => sub {
        if(&show(1) == 1){
            my $num = &get_num();
            my $rec = $spisok[$num-1];
            print "Edit Name of the record $num!\n";
            $rec -> {name} = &check_name($rec -> {name});
            print "Edit Age of the record $num!\n";
            $rec -> {age} = &check_age($rec -> {age})

        }
    },
    3 => sub {
        if(&show(1) == 1){
            my $num = &get_num();
            splice(@spisok, --$num, 1);
            print "Record number ".++$num." has been deleted\n\n" 
        }
    },
    4 => sub {
        &show();
    },
    5 => sub {
        if($#spisok != -1){
            my %A;
            my $i = -1;
            dbmopen(%A, "file", 0666);
            foreach my $pers (@spisok){
                $A{++$i} = join('::::', $pers -> {name}, $pers -> {age});
            }
            dbmclose(%A);
            print "Successful.\n"
        }
        else{
            print "There is nobody in the list\n"
        }
    },
    6 => sub {
        my %A;
        my $i = -1;
        @spisok = ();
        dbmopen(%A, "file", 0666) or die "ERROR";
        while ( my ($key, $value) = each(%A) ) {
            (my $name, my $age) = split('::::', $value);
            my %rec = (
                name => $name,
                age => $age
            );
            push(@spisok, \%rec);
        }
        dbmclose(%A);
        print "Successful.\n\n"
        
    },
    7 => sub {
        last
    }
);
 
 
 
sub menu(){
    print "Menu\n1)Add\n2)Edit\n3)Delete\n4)Show List\n5)Write *.dbm\n6)Read from file\n7)Exit\n";
    my $choice = <STDIN>;
    chomp($choice);
    if (($choice =~ /\D/) || ($choice>7) || ($choice<1)){
        print "Repeat your choice.\n"
    }
    else{
        $arr_fun{$choice}->()
    }
}

sub ST13{ 
    while(1){
        &menu();
    }
}

return 1;