Container to easily set up Interactive Brokers Gateway in a headless environment.

In progress.

###TODO

[] Get working with demo account
[] Mount settings directory from host into container
[] Get logs available as docker logs

Credit to: https://docs.google.com/document/d/1qWt43XamkNt6-P9QyyiyT0kJLBQa7g23atF_Ti5rEVg/edit

Rather than start TWS with `IBControllerGatewayStart.sh` or similar, we pass those environment variables in
at container launch time and call the launch script directly.
