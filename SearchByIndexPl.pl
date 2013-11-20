use 5.010;
use File::Path qw/make_path remove_tree/;
use File::Find;

@ig_dir=qw/\bbuild$ \b\.svn$ \b\.git$/;
@ig_files=qw/\.bak$ \.bd$ \.dll$ \.a$ \.bin$ \.lib$ \.gif$ \.bmp$ \.png$ \.so$ \.elf$ \.ttf$/;
$pro_dir_name='__MyPrpDirForSearch__'
&main;
sub main {
	print "Input work dir:\n";
	chomp($work_dir=<STDIN>);
	die"Can not find this dir:$work_dir" unless -e $work_dir and -d $work_dir;
	&gen_my_pro($work_dir,$pro_dir_name); 
	
}
sub gen_my_pro {
	my($work_dir,$pro_dir_name)=@_;
	#generate a project direct
	mkdir $pro_dir_name  if !e $work_dir;#if this isn't the project direct,generate one!
	die"Cant find the pro:$pro_dir_name\n" if !e $work_dir;#if not exist the pro dir,die!!!
	
}
sub get_file_list {
	my($work_dir,$ig_dir_ref,$ig_files_ref)=@_;	
	%option={
		wanted=>\&find_list,
		preprocess=>\&_find_fliter
	}
	find(\%option,$work_dir);
}
sub find_list{
	foreach my $y (@ig_files) {
		
	next if -d $_;
	next if (
			/\.so$/i
			||/\.a$/i
			||/\.bin$/i
			||/\.elf$/i
			||/\.txt$/i
			||/\.dll$/i
			||/\.lib$/i
			||/\.ttf$/i
			||/\.text$/i
			||/\.dex$/i
			||/\.dpk$/i
			||/\.class$/i
			||/\.pdf$/i
			||/\.png$/i
			||/\.bmp$/i
			||/\.gif$/i
	);
	print HAND $File::Find::name."\n" if !-d $_;
	}
}
sub find_fliter {
	undef @arr;
	@arr=@_;
	foreach my $x (@ig_dir) {
		@arr=grep{$_ !eq $x}@arr;
	}
}
