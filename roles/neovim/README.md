# Neovim

## Post Installation

### Create a neovim virtual environment with the neovim package in it

```
pyenv virtualenv 3.9.9 neovim
pyenv activate neovim
pip install neovim
```


### Run :LspInstall

```
nvim
:LspInstall jsonls dockerls bashls tsserver pyright taplo terraformls vimls yamlls
```

#### Notes

* The `remark_ls` language server was tried, but keeps complaining that it cannot
  find `remark` locally. I've tried installing `remark` into various
  `node_modules`, including the `remark_ls` node modules directory.

* The `spectral` language server is for OpenAPI, but does not appear available
  via LspInstall

* TODO: See https://github.com/kabouzeid/nvim-lspinstall/issues/83 about running this install from the command line


### Run :TSInstall

```
:TSInstall bash cmake comment dockerfile graphql javascript json make lua python regex rst toml typescript vim yaml
```
