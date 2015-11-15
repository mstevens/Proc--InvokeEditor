use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile1(
    'NAME'		=> 'Proc::InvokeEditor',
    'VERSION_FROM'	=> 'lib/Proc/InvokeEditor.pm', # finds $VERSION
    'PREREQ_PM'		=> {
                       'File::Temp' => 0.12,
                       'Carp::Assert' => 0.11,
                       'File::Spec' => 0.82,
                       'IPC::Cmd' => 0,
    }, # e.g., Module::Name => 1.1
    'TEST_REQUIRES' => {
                       'Test::More' => 0.08,
    },
    'dist' => {
                'COMPRESS' => 'gzip -9f',
                'SUFFIX'    => 'gz',
    },
    ABSTRACT_FROM => 'Interface to external editor from perl',
    AUTHOR => 'Michael Stevens <mstevens@etla.org>',
    LICENSE => 'perl',
    META_MERGE => {
        resources => {
            repository => 'https://github.com/mstevens/Proc--InvokeEditor',
        },
    },
);

sub WriteMakefile1 {  #Compatibility code for old versions of EU::MM. Written by Alexandr Ciornii, version 0.23. Added by eumm-upgrade.
    my %params=@_;
    my $eumm_version=$ExtUtils::MakeMaker::VERSION;
    $eumm_version=eval $eumm_version;
    die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
    die "License not specified" if not exists $params{LICENSE};
    if ($params{AUTHOR} and ref($params{AUTHOR}) eq 'ARRAY' and $eumm_version < 6.5705) {
        $params{META_ADD}->{author}=$params{AUTHOR};
        $params{AUTHOR}=join(', ',@{$params{AUTHOR}});
    }
    if ($params{TEST_REQUIRES} and $eumm_version < 6.64) {
        $params{BUILD_REQUIRES}={ %{$params{BUILD_REQUIRES} || {}} , %{$params{TEST_REQUIRES}} };
        delete $params{TEST_REQUIRES};
    }
    if ($params{BUILD_REQUIRES} and $eumm_version < 6.5503) {
        #EUMM 6.5502 has problems with BUILD_REQUIRES
        $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
        delete $params{BUILD_REQUIRES};
    }
    delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
    delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
    delete $params{META_MERGE} if $eumm_version < 6.46;
    delete $params{META_ADD} if $eumm_version < 6.46;
    delete $params{LICENSE} if $eumm_version < 6.31;

    WriteMakefile(%params);
}
