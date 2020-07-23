# github-relay-ci workflow

This workflow links a github repository containing a Pulumi
application to Relay, in order to run CI (test) and CD (deploy)
through the Relay service.

## Usage

To use this workflow:
- add it to your relay account
- configure a Slack connection called 'my-workspace' 
  (or change this code to match your real connection's name)
- add workflow secrets for your pulumi and github accounts 
- copy the webhook url from the relay UI
- in your pulumi app repo on github, go to settings->webhooks
- paste the webhook url and set it to execute on PRs

