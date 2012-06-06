# Class: httpd
#
# This class manages httpd
# It is  what drives the installation, configuration,
# and service management of the httpd software.
#
# This class demonstrates a parameterized class, as well
# as class inheritance. This httpd class inherits from
# an httpd::params class. 
#
# Passing variables in via parameters or inheriting variables
# from a params class are not mutually exclusive, but the 
# both accomplish essentially the same thing. 

# The third option is to use a function like extlookup or hiera. 
# They source a config file providing data abstraction.
#
# I personally prefer a config file driven architecture. What
# ever your choice, it is about exposing the various levers 
# in your system which can provide a tunable operational system.
#
# Parameters:
#  $service_enable
#  $service_ensure 
#  $service_hasstatus
#  $service_hasrestart
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class httpd (
  $service_enable = 'false',
  $service_ensure = 'stopped',
  $service_hasstatus = 'true',
  $service_hasrestart = 'true',
  $owner = "root",
  $group = "root") inherits httpd::params {


  # include httpd::install, httpd::config, httpd::service
  #
  # Using an include function is a short cut, and doesn't
  # allow you to pass parameters and  meta-parameters 
  # such as require and before on your classes. 
  # Puppet's idempotence, can bite new users
  # and can be confusing. It is important to always  
  # describe the run order of your types. 

  # The Pro Puppet book organizes types into three seperate 
  # classes. An install class, a config class, and a service 
  # class which follows and gathers together the familiar
  # system administration pattern. 

  # Calling them as any other type, an using the class type,
  # allows you to pass paramters and meta-parameters to 
  # a class
    class {"httpd::install": } 
    class {"httpd::config": } 
    class {"httpd::service": } 

  #A call of hte apache::vhost parameterized class. Example
  #from Pro Puppet book on pg 59.
    apache::vhost {"www.example.com":
      port => 80,
      docroot => "/var/www/",
      ssl => false,
      priority => 10,
      serveraliases => "home.example.com",
    }

    # The line below uses a syntax shortcut to enforce order,
    # requiring puppet to run the install then config and finally 
    # the service classes.
    Class["httpd::install"] -> Class["httpd::config"] -> Class["httpd::service"] -> Class["apache::vhost"]

}
