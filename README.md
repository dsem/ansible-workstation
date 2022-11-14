# Workstation Configuration Management

## Introduction

This is a repository to configure a workstation with my tooling and settings
using Ansible. The repo targets the environments that I generally use, MacOS
and Fedora Linux (installed on a Google Pixelbook).

### Motivation

Many of us have spent years tweaking and optimizing a computer, only to
eventually set that computer aside and get a new one. Then we're back at square
one and we spend years tweaking and optimizing all over again. After a few
iterations, we get ideas like:

* I should document these steps so next time I don't have to figure out how to
  get these tweaks to work again!
* I could write a script to do this automatically next time!

For me, my documentation had gaps or got lost. At best, they were still
laborious to go through. My scripts were brittle and of varying completeness.
And they are not cross-platform.

Eventually, I found myself reluctant to add a new Vim plugin or try a new
command-line tool because I knew it would be short-lived. Unless it was really
important, once I got to my next workstation, I would probably not have it
again.

Using configuration management for my workstation changed that.  It's more work
upfront to orchestrate a new tool via Ansible, but the output is permanent. The
feeling that this type of work is temporary and the worry that it might not be
worthwhile is replaced with the satisfaction of having added something that is
a long-term improvement to my developer experience.  I am eager to add roles to
this playbook and to tune them perfectly because it's like I'm building a
compendium of tools, tweaks, and plugins for my perfect workstation.

### Features

- A cross-platform playbook that provides a similar workstation experience for
  both MacOS and Linux (kind of).
- Standard organization for tooling source code (`~/.local/src`) and
  configuration (`~/.config`).
- A `~/.bashrc.d/` folder for configuring bash instead of `.bash_profile` or
  `.bashrc`.

### Caveats

- The entire playbook is only run once every couple years (when I need to
  configure a whole new work station). If you're running the whole playbook,
  expect it to be bumpy!
- Consideration has only been made for compatibility with Fedora Linux. Many
  roles may work with other Linuxes out-of-the-box, but some will definitely
  not.
- `macpaste` points to a custom version configured for Dvorak! It's also
  clunky. I don't recommend it unless you *really* want copy-on-select on
  MacOS.

### What is Ansible?

Ansible is a class of software known as "Configuration Management". It's like
`chef` or `puppet`, but requires no upfront inventory configuration nor central
coordinating server or process. It can be deployed in a fully distributed
manner.

A very nice feature of configuration management tools is that they are
declarative and idempotent. In an Ansible role, you declare the state that you
want (e.g., this package should be present, this file should contain these
lines) and the role will ensure that the system matches the desired state,
whether its run a single time or multiple times.

**_NOTE_**: Ansible allows for running raw shell commands, which require
special considerations to ensure they're idempotent.

### This Repository's Layout

The structure of this repository diverges from the [recommended Ansible
layouts](https://docs.ansible.com/ansible/latest/user_guide/sample_setup.html).
It is simpler in that there is no inventory structure and requires no
inventory-related variables, hostnames, or groupings; nor does it have separate
playbooks targeting specific combinations of inventories.

However, it is more complex than a single playbook containing all the tasks to
be run.

This repository has:

- A number of roles, each responsible for installing and configuring a single
  application.
- A single playbook that references the roles.

#### Roles

Roles are stored in the `roles/` directory.

Each role follows the standard directory structure for Ansible roles, which
commonly includes subdirectories for `files/`, `tasks/` and `meta/` (as well as
a few others). For example, here is the tree for the Neovim role:

```
neovim
├── files
│   ├── .bashrc.d
│   │   └── 50-neovim.sh
│   ├── .config
│   │   └── nvim
│   │       ├── init.vim
│   │       ├── lua
│   │       │   ├── nvim-cmp.lua
│   │       │   └── nvim-lspconfig.lua
│   │       └── vim
│   │           ├── telescope.vim
│   │           └── ultisnips.vim
│   └── .local
│       └── bin
│           └── vi
├── meta
│   └── main.yml
├── README.md
└── tasks
    └── main.yml
```

* **`files/`** - The `files/` directory contains the literal files to be copied
  by the role. They are typically the app's configuration file and are laid out
  in a directory structure that mirrors where they'll be placed on the
  filesystem when copied.

* **`meta/`** - The `meta/main.yml` file lists the role's dependencies on other
  roles. This instructs Ansible to run those roles prior to running the main
  role. Since roles are organized into individual applications, roles might
  depend on other individual applications. For example, Hashicorp apps like
  Terraform depend on the `hashicorp-repository`. Defining dependencies like
  this helps reduce repeating the same tasks across different roles as well as
  allows for running all the needed steps when targeting a single role.

* **`README.md`** -  If a role requires any manual step or needs anything to be
  noted, it is captured in a `README.md` file in the root of the role.

* **`tasks/`** - The `tasks/main.yml` file contains the commands to be run
  (e.g., install this package, copy this configuration file). When installing
  packages, the [Ansible
  Package](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/package_module.html)
  module is used, which allows the role to declare a package should be present
  in an OS-independent way (under the hood it uses `dnf` for Fedora, `brew` for
  MacOS, etc.).

  When different commands should be run for Linux and MacOS, they are separated
  into a `macos.yml` and `linux.yml` files. In these cases, the `main.yml`
  uses an `include_tasks` directive to call the appropriate task file:

  ```
  - name: Included distribution-specific tasks
    include_tasks: "{{ os }}.yml"
  ```

#### Playbook

This repo contains a single playbook, [`main.yml`](./main.yml). The playbook
references roles under the `roles/` directory. Not all roles are referenced in
the main playbook, as some are only dependencies of other roles.

## Running

### Dependencies

In order to configure a machine using this playbook, the must have:

1. A package manager (`dnf` on Fedora, `brew` on MacOS)
2. Git and this repo
3. Ansible

On MacOS, [install Homebrew](https://brew.sh), then git and Ansible.

```
brew install git ansible
```

On Linux, install git and Ansible

```
sudo dnf install git ansible
```

Then, clone this repository:

```
mkdir -p ~/.local/src
cd ~/.local/src
git clone https://github.com/dsem/ansible-workstation.git
```

### Running the Entire Playbook

#### Handling apps not distributed through package managers

Some applications aren't distributed through package managers and so the
playbook downloads an artifact and installs it directly. Often times this
artifact is only exposed through a URL that includes the version to be
downloaded.  When running the playbook for the first time, you probably want
the latest version of each of these apps, not whatever version was captured the
last time the role was updated.

For easy maintenance, these application versions are captured as variables in
the [`grop_vars/all`](./group_vars/all) file. Before running the playbook,
consider going through that file and set the variables to the latest version of
each app.

#### Running `ansible-playbook`

On MacOS, first execute the pre-playbook in order to set the shell as `bash`

```
ansible-playbook -K pre.yml
```

Then open a new shell and execute the main playbook:

```
ansible-playbook -K main.yml
```

On Linux, execute the playbooks together:

```
ansible-playbook -K pre.yml
ansible-playbook -K main.yml
```

### Running a single role

As the workstation tooling evolves, it's common to add a new role to the
playbook, then run just that role to verify the playbook installs and
configures it properly.

I wish this were easier. The best way I've found is to temporarily tag the
role in [`main.yml`](./main.yml) with a dummy tag and then call Ansible
targeting that tag.

For example, to run just the `neovim` role change the `main.yml` file from:

```
---
- hosts: localhost
  roles:
    ...
    - neovim
    ...
  connection: localhost
```

To

```
---
- hosts: localhost
  roles:
    ...
    - role: neovim
      tags: this
    ...
  connection: localhost
```

Then run Ansible with the `--tags` argument:

```
ansible-playbook main.yml -K --tags this
```

## Hardware-specific tips

See https://github.com/jmontleon/pixelbook-fedora for configuring the Google
Pixelbook hardware to work on Fedora.

# TODO

* Figure out how to collect all roles' READMEs into a central place to easily
  see what manual steps are needed
* Figure out a way to test these roles!
* Figure out a way to coordinate running newly-added roles on other
  workstations
