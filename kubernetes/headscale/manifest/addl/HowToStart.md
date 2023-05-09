# Running Headscale command
```
# Create an alias for easy usage
alias headscale="kubectl -n my-headscale exec deploy/headscale -c headscale -it -- headscale"

# Add completion
headscale completion bash > /etc/bash_completion.d/headcompletion
```
# Remote connect
```
# Install binary localy
wget https://github.com/juanfont/headscale/releases/download/v0.22.1/headscale_0.22.1_linux_amd64.deb
sudo apt install -f ./headscale_0.22.1_linux_amd64.deb

export HEADSCALE_CLI_ADDRESS="<HEADSCALE ADDRESS>:<PORT>"
export HEADSCALE_CLI_API_KEY="<API KEY FROM PREVIOUS STAGE>"
```
# Create first user
```
headscale users create myfirstuser
```
# Register a machine (login)
```
# Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Login
tailsacle up --accept-routes --login-server=https://<YOUR_HEADSCALE_URL>
headscale --user myfirstuser nodes register --key <YOU_+MACHINE_KEY>

# Preauth
headscale --user myfirstuser preauthkeys create --reusable --expiration 24h
tailscale up --login-server https://<YOUR_HEADSCALE_URL> --authkey <YOUR_AUTH_KEY>
```
# Manage nodes
```
# List for index
headscale nodes list

# List routes with index
headscale routes list -i 1
headscale routes enable -a -i 1
```