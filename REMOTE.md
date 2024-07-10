# Running on a Remote Host

Certain steps of bootstraping of a new workstation can only be achieved when
running the playbook from a pre-configured workstation.  This includes:

 - Uploading public SSH keys to gitlab and github.
 - Transferring gpg keys for password-store
 - Installing initial dependencies like git and ansible

There is a dedicated playbook, `bootstrap-remote.yml` that enables this setup
and allows the rest of the main playbook to run.

## Running

On the remote host, the machine to be bootstrapped, enable remote login

**MacOS**: Settings -> General -> Sharing -> toggle Remote Session

**Linux**: Enable the `sshd` service.

Find the local IP by running `ifconfig | grep inet` and looking for a local IP address.

On the local host, the machine that's already configured, copy over the public ssh key:

```
scp ~/.ssh/id_ed25519.pub dylan@<ip address>:.ssh/authorized_keys
```

Then, run the bootstrap-remote playbook

```
ansible-playbook -i <ip address>, -u <user> bootstrap-remote.yml
```

## Troubleshooting

If the "Add public key to gitlab" role erros with

```
x failed to add new ssh public key error=POST https://gitlab.com/api/v4/user/keys: 401 {error: invalid_token}, {error_description: Token is expired. You can either do re-authorization or token refresh.}
```

Navigate to https://gitlab.com/-/user\_settings/personal\_access\_tokens and
issue a new token with `api` and `write_repository` scopes.

Then run

```
glab auth login
```

and paste the created token.
