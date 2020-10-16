# pulumi-step-run

This step runs pulumi in a CI-style environment.

It is based on (and attempts compatibility with) the [pulumi/actions](https://www.pulumi.com/docs/guides/continuous-delivery/github-actions/) container for use under GitHub Actions.

The `event_payload` parameter is easiest to provide using the [`github-trigger-event-sink`](https://github.com/relay-integrations/relay-github/tree/master/triggers/github-trigger-event-sink) webhook trigger.

See the [`github-relay-ci.yaml`](https://github.com/relay-integrations/relay-pulumi/tree/master/workflows/github-relay-ci) workflow for a working example using this step.
