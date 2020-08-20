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
# if we're operating on a pull request, set PULUMI_CI=pr
[[ $(jq -e .pull_request.number $GITHUB_EVENT_PATH) ]] && PULUMI_CI=pr

# ultra-simple copy of actions/checkout@v2 
git clone $(jq -r .repository.clone_url $GITHUB_EVENT_PATH) ${GITHUB_WORKSPACE}
cd ${GITHUB_WORKSPACE} || (echo "could not find repo directory" && exit 1)

/usr/bin/pulumi-action ${PULUMI_ARGS}
