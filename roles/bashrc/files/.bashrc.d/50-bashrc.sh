# Some unix scripts always assume the OS is using the correct bash confiuration
# file (.bashrc). MacOS uses .bash_profile. This bit improves compatibility for
# these cases.
if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi
