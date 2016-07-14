# ~/.profile: executed by the command interpreter for login shells.
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
   fi
fi

