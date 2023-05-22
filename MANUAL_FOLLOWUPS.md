# Manual Followups

After running the playbook for the first time on a new workstation, follow these steps to finish setting everything up.


## Garmin ConnectIQ SDK

Install [Visual Studio Code](https://code.visualstudio.com/) in order to
initialize new projects.


## iTerm2

Import the curated profile for iTerm2. In the iTerm2 menu, select:

iTerm2 -> Settings -> Profiles -> Other Actions... -> Import JSON Profiles...

Select the [iterm2-profile.json](iterm2-profile.json) in this directory.

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
