#!/bin/bash

# this entrypoint provides a compatibility layer
# between relay.sh and the github actions API that
# the real pulumi/actions entrypoint expects

# export all variables for use in the pulumi entrypoint
set -a 
# alternate backend to use, can be empty
PULUMI_BACKEND_URL=$(ni get -p {.pulumi_backend_url})
# secret, needed to login
PULUMI_ACCESS_TOKEN=$(ni get -p {.pulumi_access_token})
# for future use - these mimic running against a PR for CI
PULUMI_CI=
PULUMI_ROOT=
GITHUB_WORKFLOW=
GITHUB_EVENT_PATH=/github/workflow/event.json
# we must create this file from the parameter
mkdir -p /github/workflow
ni get | jq .event_payload > $GITHUB_EVENT_PATH

# set to override in-repo branch mappings
BRANCH=

# cloud credentials needed to actually change things
GOOGLE_CREDENTIALS=
NPM_AUTH_TOKEN=

## now the actual runtime requirements
# this becomes the commandline for the real entrypoint
PULUMI_ARGS=$(ni get -p {.pulumi_commandline})
GITHUB_TOKEN=$(ni get -p {.github_token})
GITHUB_WORKSPACE=/workspace

# ultra-simple copy of actions/checkout@v2 
git clone $(jq .repository.ssh_url $GITHUB_EVENT_PATH) ${GITHUB_WORKSPACE}
cd ${GITHUB_WORKSPACE}

/usr/bin/pulumi-action ${PULUMI_ARGS}
