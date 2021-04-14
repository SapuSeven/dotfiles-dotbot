# SSH Setups

This file documents common procedures for setting up passwordless SSH access on a remote server.

## Creating a new passwordless keypair

Replace `USER` and `HOST` accordingly.

The `-N` specifies that no password should be used.

```
ssh-keygen -t ed25519 -C USER@HOST -f ~/.ssh/passwordless/USER@HOST -N ""
```

## Uploading keys to server

Replace `USER` and `HOST` accordingly.
```
ssh-copy-id -i ~/.ssh/passwordless/USER@HOST USER@HOST
```

## Adding all passwordless keys to `ssh-agent`

Using `zsh`:
```
setopt EXTENDED_GLOB
ssh-add ~/.ssh/passwordless/*~*.pub
```

Using `bash`:
```
shopt -s extglob
ssh-add ~/.ssh/passwordless/!(*.pub)
# Optionally:
shopt -u extglob
```
