# Teleport
Teleport provides connectivity, authentication, access controls and audit for infrastructure.

[GitHub Page](https://github.com/gravitational/teleport)

# Notes
1. Don't forget to replace $DOMAIN in config/teleport.yaml manually!!
2. Create your first user via 'tctl users add USERNAME --roles=editor' inside the teleport container
3. Create alias for easy usage --> alias t="docker exec -it teleport tctl"
4. Create your first user via "t users add joe --logins=joe,root --roles=access,editor"