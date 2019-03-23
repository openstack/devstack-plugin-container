================
Container Plugin
================

This plugin enables installation of container engine and Kubernetes on
Devstack. The default container engine is Docker.

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

This plugin supports installing Kubernetes or container engine only.
For installing container engine only, using the following config:

.. code-block:: ini

     cat > /opt/stack/devstack/local.conf << END
     [[local|localrc]]
     enable_plugin devstack-plugin-container https://opendev.org/openstack/devstack-plugin-container
     END

For installing Kubernetes, using the following config in master node:

.. code-block:: ini

     cat > /opt/stack/devstack/local.conf << END
     [[local|localrc]]
     enable_plugin devstack-plugin-container https://git.openstack.org/openstack/devstack-plugin-container
     enable_service etcd3
     enable_service container
     enable_service k8s-master
     # kubeadm token generate
     K8S_TOKEN="9agf12.zsu5uh2m4pzt3qba"

     ...

     END

And using the following config in worker node:

.. code-block:: ini

     cat > /opt/stack/devstack/local.conf << END
     [[local|localrc]]
     SERVICE_HOST=10.0.0.11 # change this to controller's IP address

     enable_plugin devstack-plugin-container https://git.openstack.org/openstack/devstack-plugin-container
     enable_service container
     enable_service k8s-node
     # kubeadm token generate
     K8S_TOKEN="9agf12.zsu5uh2m4pzt3qba"

     ...

     END

3. Run devstack
--------------------

.. code-block:: ini

    cd /opt/stack/devstack
    ./stack.sh
