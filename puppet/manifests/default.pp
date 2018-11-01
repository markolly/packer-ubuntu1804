#Workaround, maestrodev-wget uses three global variables which puppet 4> 
#will complain about if strict_variables is true
$http_proxy = undef
$https_proxy = undef
$schedule = undef

# Create a new run stage to ensure certain modules are included first
stage { 'pre':
    before => Stage['main']
}

# Add the base module to the new 'pre' run stage
class { 'debian_vagrant::base':
    stage => 'pre'
}

# Set defaults for file ownership/permissions
File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
}

include debian_vagrant::base
include debian_vagrant::ssh
include debian_vagrant::vboxguest
