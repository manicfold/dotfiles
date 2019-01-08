# detect if this is a remote or local session
SESSION_TYPE=local
if [ -n "$X2GO_SESSION" ]; then
    SESSION_TYPE=remote/x2go
    export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=remote/ssh
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE=remote/ssh;;
    esac
fi
export SESSION_TYPE

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# NTUID=$(whoami)
# REGION=$(adquery user -F -C $NTUID | sed -e 's/\.[^\\]*//' | sed -e 's/\(.*\)/\U\1/')

# Update OCS upon login
# LOCATION=$(cat /opt/location)
# sudo /usr/bin/ocsinventory-agent --tag=$LOCATION 2>/dev/null

# Mount share folder
# UPATH=$(cat /home/$NTUID/.path-to-drive-u)
#gvfs-mount smb://$UPATH

# Check for password expiry
# ADDATE=$(/usr/bin/adquery user -F -w $NTUID)
# ADSECOND=$(date -d "$ADDATE" +%s 2>/dev/null)
# CURRSECOND=$(date +%s)
# DELTA=$(( $ADSECOND-$CURRSECOND ))  2>/dev/null
# DAYSLEFT=$(( $DELTA/86400 ))  2>/dev/null
#DAYSLEFT=$(/opt/pbis/bin/find-user-by-name --level 2 "$REGION\\$NTUID" | grep '^Days till password expires: .*$' | sed -e 's/Days till password expires:   //g')

# if [ "$DAYSLEFT" -le "14" ] && [ "$DAYSLEFT" -gt "0" ]; then
#     echo "Your password is expiring in $DAYSLEFT day(s).\nPlease change your password as soon as possible."
#     touch /home/$NTUID/.pwd_exp
# fi
