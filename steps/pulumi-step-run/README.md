# pulumi-step-run

This step runs pulumi in a CI-style environment.

It is based on (and attempts compatibility with) the [pulumi/actions](https://www.pulumi.com/docs/guides/continuous-delivery/github-actions/) container for use under GitHub Actions.

## Specification

| Setting | Data type | Description | Default | Required |
| pulumi_backend_url | String | Alternate backend specifier | api.pulumi.io | No |
| event_payload | Stringified json | The complete payload of a github webhook | None | Yes |
| pulumi_commandline | String | The commandline to pass through to `pulumi ...` | `preview` | No |

The `event_payload` parameter is easiest to provide using the [`github-trigger-event-sink`](https://github.com/relay-integrations/relay-github/triggers/github-trigger-event-sink/) webhook trigger.

See the example [`preview-workflow.yaml`](https://github.com/relay-integrations/relay-pulumi/workflows/preview-workflow.yaml) in this repository for a working example of using this step.


