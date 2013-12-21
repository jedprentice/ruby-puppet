# Ruby Puppet
Puppet manifests for provisioning Ruby servers for web apps using Rails or
Sinatra. Also installs nodejs so I can build Javascript apps (client or server)
This may not be directly reusable, but it's at least a good start.

## Environments
Targeted at AWS AMI and other RHEL-like distros... for now at least

## Notes
To apply changes:

    $ sudo puppet apply --modulepath=modules manifests/site.pp

Work is in progress on fully provisioning the ruby stack including rbenv. I've
gotten pretty far with global rbenv provisioning, but I'm not all the way
there yet. For now, I can get all the way to the last few steps, which
have to be done manually. The following assumes Ruby 2.0, but any version should
work:

    $ rbenv install 2.0.0-p247
    $ rbenv global 2.0.0-p247
    $ gem install bundler

Then you can clone the app code and run

    $ bundle install

I needed to make a few permissions hacks in /usr/local/rbenv to support this,
namely making shims/, versions/ and version world-writable on the Vagrant box.
On a real server I could change the group ownership to devel to avoid this.

## Installing Passenger
I am hosting the app using Phusion Passenger running in Apache. Puppet is
installing the devel libs requred to compile the passenger apache module,
along with a vhost. However, I need to fill in a gap manually by running

    $ passenger-install-apache2-module

This brings up a text UI that allows one to kick off the compilation of the
Passenger Apache module. Once that is done, restart apache:

    $ sudo service httpd restart

