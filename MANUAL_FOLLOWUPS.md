# Manual Followups

After running the playbook for the first time on a new workstation, follow these steps to finish setting everything up.


## Garmin ConnectIQ SDK

Install [Visual Studio Code](https://code.visualstudio.com/) in order to
initialize new projects.


## Docker

Open the docker application via Launchpad to bootstrap accept the terms and
bootstrap the daemon


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

### Enable higher resolutions with quickres

Find the quickres email in your email history, click on the "View Content"
link, and download it again


### Disable the Spotlight keyboard shortcut

Don't show spotlight in the menu bar:

Settings -> Control Center -> Menu Bar Only -> Spotlight; select "Don't show in Menu Bar"

Prevent spotlit from indexing things, since we're not using it anyways:

Settings -> Siri and Spotlight -> Spotlight; uncheck everything

Disable the keyboard shortcut:

Settings -> Keyboard -> Keyboard shortcuts -> Spotlight; uncheck the options


## iTerm2

### Import the curated iTerm2 profile

Import the curated profile for iTerm2. In the iTerm2 menu, select:

iTerm2 -> Settings -> Profiles -> Other Actions... -> Import JSON Profiles...

Select the [iterm2-profile.json](iterm2-profile.json) in the root of the iTerm2 role.

Then set it as the default profile by clicking on "Curated Profile" -> Other Actions... -> Set as Default.

Finally, remove the "Default" profile by selecting the "Default" profile and clicking on the minus sign.

### Update out-of-profile Settings

Enable focus follows mouse:

iTerm2 -> Settings -> Pointer; select "Focus follows mouse"


## Macpaste

Go to System Preferences -> Security & Privacy -> Input Monitoring

Select Accessibility and add ~/.local/bin/macpaste

Logout and log back in again.


## BetterTouchTool

1. Open BetterTouchTool and adjust the permissions in system settings

2. Import Presets

   Go to Presets -> Import Presets

   Select the [Curated Profile.bttpreset](Curated Profile.bttpreset) file

3. Register the BTT app

   Click the BTT icon -> Register

   Download the BetterTouchTool license by searching BetterTouchTool in gmail


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