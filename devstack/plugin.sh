# container - Devstack extras script to install container engine

# Save trace setting
XTRACE=$(set +o | grep xtrace)
set -o xtrace

echo_summary "container's plugin.sh was called..."
source $DEST/devstack-plugin-container/devstack/lib/docker
source $DEST/devstack-plugin-container/devstack/lib/crio
source $DEST/devstack-plugin-container/devstack/lib/k8s
(set -o posix; set)

if is_service_enabled container; then
    if [[ "$1" == "stack" && "$2" == "install" ]]; then
        echo_summary "Installing container engine"
        if [[ ${CONTAINER_ENGINE} == "docker" ]]; then
            check_docker || install_docker
        elif [[ ${CONTAINER_ENGINE} == "crio" ]]; then
            check_crio || install_crio
        fi
    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        echo_summary "Configuring container engine"
        if [[ ${CONTAINER_ENGINE} == "docker" ]]; then
            configure_docker
        elif [[ ${CONTAINER_ENGINE} == "crio" ]]; then
            configure_crio
        fi
    fi

    if [[ "$1" == "unstack" ]]; then
        if [[ ${CONTAINER_ENGINE} == "docker" ]]; then
            stop_docker
        elif [[ ${CONTAINER_ENGINE} == "crio" ]]; then
            stop_crio
        fi
    fi

    if [[ "$1" == "clean" ]]; then
        # nothing needed here
        :
    fi
fi

if is_k8s_enabled; then
    if [[ "$1" == "stack" && "$2" == "install" ]]; then
        install_kubeadm
    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        if is_service_enabled k8s-master; then
            kubeadm_init
        elif is_service_enabled k8s-node; then
            kubeadm_join
        fi
    elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
        if is_service_enabled k8s-master; then
            start_collect_logs
        fi
    fi

    if [[ "$1" == "unstack" ]]; then
        kubeadm_reset
    fi

    if [[ "$1" == "clean" ]]; then
        # nothing needed here
        :
    fi
fi

# Restore xtrace
$XTRACE
