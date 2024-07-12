# Manual Followups

After running the playbook for the first time on a new workstation, follow these steps to finish setting everything up.


## Garmin ConnectIQ SDK

Install [Visual Studio Code](https://code.visualstudio.com/) in order to
initialize new projects.


## Docker

Open the docker application via Launchpad to accept the terms and bootstrap the
daemon


## MacOS

### Fix the keyboard

#### Enable Dvorak

1. Go to Settings -> Keyboard -> Text Input -> Input Sources -> Edit...

2. Click the "+" in the lower-left

3. Select Dvorak and click Add

4. Select the default layout and click "-"

Then, untoggle "Add period with double-space"


#### Rotate the modifier keys

1. Keyboard Shortcuts... -> Modifier Keys:

For the internal keyboard/trackpad:

* Control -> Globe
* Command -> Control
* Globe -> Command

For a bluetooth keywoard:

* Control -> Command
* Command -> Control


#### Increase key repetition speed

At the top, slide the key repetition speed and wait for repetition all the way
to the right.

### Fix the trackpad

1. Go to Settings -> Trackpad -> Scroll & Zoom

2. Untoggle "Natural scrolling"

### Enable Touch ID

1. Go to Settings -> Touch ID & Password -> Add Fingerprint

2. Follow the instructions to add your fingerprint

3. Toggle "Use Touch ID to unlock your Mac"


### Enable Night Shift

1. Go to Settings -> Displays -> Night Shift...

2. Update the Schedule dropdown to "Sunset to Sunrise"

3. Allow System Services to access your location

4. Re-navigate to Settings -> Displays -> Night

5. Update the Schedule dropdown to "Sunset to Sunrise" again

### Enable higher resolutions with quickres

Find the quickres email in your email history, click on the "View Content"
link, and download it again. Open the .dmg and drag the app to the
~/Applications directory


### Disable the Spotlight keyboard shortcut

Don't show spotlight in the menu bar:

Settings -> Control Center -> Menu Bar Only -> Spotlight; select "Don't show in
Menu Bar"

Prevent spotlight from indexing things, since we're not using it anyways:

Settings -> Siri and Spotlight -> Spotlight; uncheck everything

Disable the keyboard shortcut:

Settings -> Keyboard -> Keyboard shortcuts -> Spotlight; uncheck the options


### Fix the Launcher

1. Shrink the launcher. Find a vertical bar and click-and-drag until the
   launcher is the smallest. Note that if you click to low on the vertical bar,
   the mouse will reach the edge of the screen before the bar is the smallest,
   so either try shrinking it again.

2. Remove unused applications. Click and hold an application icon and drag it
   out of the launcher until it says "Remove".


## Bash-It!

Enable plugins and aliases:

```bash
bash-it enable plugin alias-completion gitstatus
bash-it enable alias git
bash-it enable completion ssh docker docker-compose gcloud
```


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


## Raycast

Open Raycast and follow the steps to setup the app.

### Install Extensions

Go to Extensions -> "+" -> "Install from store"

Install the following extensions:

* Google Workspace
* Google Chrome
* Spotify Player


## Macpaste

Go to System Preferences -> Privacy & Security -> Input Monitoring

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


## Slack

### Sign into the workspaces

1. Open slack and log in with Google.

2. Click on the Workspace icon -> "Add a workspace" -> Sign in with the other Google

### Fix preferences

1. CLick on the user profile icon in the lower-left -> Preferences ->  Accessibility" -> Keywoard

Press <up> to Edit your last message.


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
:Copilot setup
:Copilot enable
```