# Pyenv

Re-sourcing the shell doesn't work, so the `pyenv` commands at the end of the tasks file do not work


### Linux issue with pyenv not using local python versions

I have run into [this issue](https://github.com/pyenv/pyenv/issues/849#issuecomment-875875617). It may be fixed by the upstream installers but if pyenv and virstualenvs all appear to be using the global python, try changing

```
  eval "$(pyenv init -)"
```

to

```
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
```

(Note the issue only describes replacing `-path` with `--path`. Doing so got `pyenv` working correctly but `pyenv-virtualenv` did not. I had to add both lines to get `pyenv-virtualenv` to work.
