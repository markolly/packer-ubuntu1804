# == Class: baseconfig
#
# Performs initial configuration tasks for Vagrant boxes.
#
class baseconfig {

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  $timezone = 'Europe/London'
  $set_timezone = [$timezone]
  $set_timezone_file = '/etc/timezone'
  $packages = ['htop','tree','unzip','vim']

  case $::osfamily {
      /Debian/: {

        file { $set_timezone_file:
          content => $set_timezone,
          notify  => Exec['update timezone'];
        }
        exec { 'apt-get update':
          command => 'apt-get update';
        }
        package { $packages:
          ensure => present;
        }
        exec { 'update timezone':
          command => 'dpkg-reconfigure -f noninteractive tzdata';
        }

      } default: {

        exec { 'yum update':
          command => 'yum update';
        }
        package { $packages:
          ensure => present;
        }
        exec { 'update timezone':
          command => "timedatectl set-timezone ${timezone}";
        }

      }
  }

}
