================
Container Plugin
================

This plugin enables installation of container engine on Devstack. The default
container engine is Docker (currently this plugin supports only Docker!).

====================
Enabling in Devstack
====================

1. Download DevStack
--------------------

For more info on devstack installation follow the below link:

.. code-block:: ini

  https://docs.openstack.org/devstack/latest/

2. Add this repo as an external repository
------------------------------------------

.. code-block:: ini

     cat > /opt/stack/devstack/local.conf << END
     [[local|localrc]]
     enable_plugin devstack-plugin-container https://git.openstack.org/openstack/devstack-plugin-container
     END

3. Run devstack
--------------------

.. code-block:: ini

    cd /opt/stack/devstack
    ./stack.sh
