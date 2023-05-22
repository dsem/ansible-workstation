# Manual Followups

After running the playbook for the first time on a new workstation, follow these steps to finish setting everything up.


## Garmin ConnectIQ SDK

Install [Visual Studio Code](https://code.visualstudio.com/) in order to
initialize new projects.


## MacOS

### Rotate modifier keys

Rotate the modifier keys for a more familiar keyboard:

Settings -> Keyboard -> Keyboard Shortcuts -> Modifier Keys:

For the internal keyboard/trackpad:

* Control -> fn Function
* Command -> Control
* Function -> Command

### Key repetition speed

Speed up the rate at which keys repeat to maintain sanity:

Settings -> Keyboard:

Slide the key repetition speed and wait for repetition all the way to the right.


## iTerm2

Import the curated profile for iTerm2. In the iTerm2 menu, select:

iTerm2 -> Settings -> Profiles -> Other Actions... -> Import JSON Profiles...

Select the [iterm2-profile.json](iterm2-profile.json) in the root of the iTerm2 role.

Then set it as the default profile by clicking on "Curated Profile" -> Other Actions... -> Set as Default.

Finally, remove the "Default" profile by selecting the "Default" profile and clicking on the minus sign.


## Neovim

Create a neovim virtual environment with the neovim package in it:

```
pyenv virtualenv 3.9.9 neovim
pyenv activate neovim
pip install neovim
```

Install language servers with `:LspInstall`

```
nvim
:LspInstall ansiblels jsonls dockerls bashls tsserver pyright taplo terraformls vimls yamlls
```

Install treesitter configurations with `:TSInstall`:

```
:TSInstall bash cmake comment dockerfile graphql javascript json make lua python regex rst toml typescript vim yaml
```

### Setup and enable Copilot

```
:Copilot Setup
:Copilot enable
```