package ST26;

use strict;
use warnings;
use st26::Person;

my @group;  
my $res = 1;
my $filename = "st26db";

#helper functions
my $check_input = sub { 
    while( my $choice = <STDIN> ) {
            chomp $choice;
            if ( $choice =~ m/\d+/ && $choice <= @group && $choice>0 ) {
                return $choice;
            }

            print "\nInvalid input\n\nYour choice: ";
       }    
};

my $group_IsNull = sub { 
    if(@group >0)
    {
        return 1;
    }
    else
    {
        print "\n######### Group is empty. Create or load group !!! ########\n" ;
        return 0;
    }
};

#menu function 
sub menu {
    my @items = @_;
    my $count = 0;
    for my $item( @items ) {
        printf "%d: %s\n", ++$count, $item->{text};
    }

    print "\nYour choice: ";

    while( my $line = <STDIN> ) {
        chomp $line;
        if ( $line =~ m/\d+/ && $line <= @items && $line>0 ) {
            return $items[ $line - 1 ]{code}();
        }

        print "\nInvalid input\n\nYour choice: ";
    }
};

#print students function 
my $print_students = sub { 
    if(&$group_IsNull == 1)
    {
        print "\n######### Print Group ########\n" ;
        my $count = 0;
        for my $item( @group ) {
            printf "%d: FName:%s LName:%s id:%d \n", ++$count, $item->getFirstName(),$item->getLastName(),$item->getID();
        }
        print "\n";
    }
};

#add student function 
my $add_student = sub { 
    print "\n########## Add Student  #########\n" ;
    print "First Name :\n";
    chomp (my $f_name = <STDIN>);
    print "Last Name :\n";
    chomp (my $l_name = <STDIN>);
    print "ID: \n";
    chomp (my $id = <STDIN>);
    push(@group,Person->new($f_name, $l_name, $id));
    &$print_students(); 
};

#edit student function 
my $edit_student = sub { 
    if(&$group_IsNull == 1)
    { 
        print "\n########## Edit Student  #########\n" ;
        &$print_students(); 
        print "Enter student number:\n";
        my $choice = &$check_input();
        print "First Name :\n";
        chomp (my $f_name = <STDIN>);
        $group[$choice-1]->setFirstName($f_name); 
        print "Last Name :\n";
        chomp (my $l_name = <STDIN>);;
        $group[$choice-1]->setLastName($l_name); 
        print "ID: \n";
        chomp (my $id = <STDIN>);
        $group[$choice-1]->setID($id); 
        &$print_students();
    }
};

#delete_student function 
my $del_student = sub { 
    if(&$group_IsNull == 1)
    {
        print "\n######### Delete Student ########\n" ;
        &$print_students(); 
        print "Enter student number:\n";
        my $choice = &$check_input();
        splice @group,$choice-1,1;
        &$print_students();
    }  
};

#save students to dbm file function 
my $save_students = sub { 
    if(&$group_IsNull == 1)
    {
        print "\n######### Save Group ########\n";
        dbmopen(my %data, $filename, 0666) or die "Cant open $filename file\n";
        %data = ();
        my $count = 0;
        foreach (@group) { 
            $count+=1;
            $data{"$count"} =$_->getPerson() ;
        }     
        dbmclose(%data);
    }
};

#load students from dbm file function 
my $load_students = sub { 
        undef(@group);
        print "\n######### Load Group ########\n" ;
        dbmopen(my %data, $filename, 0444) or die "Cant open $filename file\n";  
        foreach my $key ( keys %data ) {
            (my $f, my $l,my $id )= split(/::@::/,$data{$key});
             push(@group,Person->new($f, $l, $id));
        }
        dbmclose(%data);
        &$print_students(); 
};

# menu 
my @menu_choices = (
    { text  => 'add student',
      code  =>  $add_student},
    { text  => 'edit student',
      code  =>  $edit_student},
    { text  => 'delete student',
      code  => $del_student },
    { text  => 'print group',
      code  => $print_students },
    { text  => 'save',
      code  => $save_students },
    { text  => 'load',
      code  => $load_students },
    { text  => 'exit',
      code  =>  sub { $res = 0;}}
);

sub st26 
{
    $res = 1;
	while($res)
	{
		menu( @menu_choices );
	}
}
return 1;