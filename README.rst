=================
 Container Plugin
=================

This plugin enables installation of container engine on Devstack. The default
container engine is Docker.

======================
 Enabling in Devstack
======================

1. Download DevStack

2. Add this repo as an external repository::

     > cat local.conf
     [[local|localrc]]
     enable_plugin devstack-plugin-container https://github.com/openstack/devstack-plugin-container

3. run ``./stack.sh``
