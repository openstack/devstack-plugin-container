#!/bin/bash -x
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# This script is executed inside post_test_hook function in devstack gate.

# Sleep some time until all services are starting
sleep 5

# Check if a function already exists
function function_exists {
    declare -f -F $1 > /dev/null
}

if ! function_exists echo_summary; then
    function echo_summary {
        echo $@
    }
fi

# Save trace setting
XTRACE=$(set +o | grep xtrace)
set -o xtrace

echo_summary "Devstack-plugin-container's post_test_hook.sh was called..."
(set -o posix; set)

# Verify that Docker is installed correctly by running the hello-world image
sudo -H -u stack docker run hello-world

EXIT_CODE=$?

# Copy over docker systemd unit journals.
mkdir -p $WORKSPACE/logs
sudo journalctl -o short-precise --unit docker | sudo tee $WORKSPACE/logs/docker.txt > /dev/null

$XTRACE
exit $EXIT_CODE
