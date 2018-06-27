# ~/.profile: executed by the command interpreter for login shells.
# if running bash
SESSION_TYPE=local
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi
export SESSION_TYPE

if [ -n "$X2GO_SESSION" ]; then
   export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
fi

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
   fi
fi

