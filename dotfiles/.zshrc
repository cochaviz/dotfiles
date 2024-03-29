export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="bunker"

# Much faster git preview
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Date stamps
HIST_STAMPS="dd/mm/yyyy"

# Plugins
plugins=(
	git 
	zsh-syntax-highlighting 
	zsh-autosuggestions
        emoji
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases
alias bspwmrc="$EDITOR $HOME/.config/bspwm/bspwmrc"
alias sxhkdrc="$EDITOR $HOME/.config/sxhkd/sxhkdrc"
alias mkgrubcfg="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias launchplayer="sudo modprobe -a vmw_vmci vmmon && sudo systemctl start vmware.service && sudo systemctl start vmware-networks-server.service && sudo vmplayer /home/zohar/Documents/Study/y2/q4/SP/doc/Lubuntu\ 20.04.M.1.2/Lubuntu\ 20.04/Lubuntu\ 20.06\ LTS\ 64-bit.vmx &> /dev/null & ; disown"
alias logout="loginctl kill-user zohar"
alias kssh="kitty +kitten ssh"
alias startworkenv="launchplayer && kssh root@193.168.0.156"
alias svenv="source ./venv/bin/activate"
alias cci="circleci"
alias espenv=". $HOME/esp/esp-idf/export.sh"
alias layout="$EDITOR $HOME/.config/qmk/keyboards/sofle/keymaps/zoharcochavi/keymap.c"
alias startups="$EDITOR $HOME/.scripts/startups"
alias evil="emacsclient -t"
alias emacsd="emacs --daemon"
alias please="sudo"

# Exports
export XSECURELOCK_IMAGE_PATH=/home/zohar/Pictures/wallpaper.jpg
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH=$PATH:$HOME/.local/share/nvim/bin/:$JAVA_HOME:$HOME/.scripts/
export _JAVA_AWT_WM_NONREPARENTING=1
export LAN="192.168.0"
export CHROME_EXECUTABLE="google-chrome-stable"


# SSH keys 
# eval $(ssh-agent -s) &> /dev/null
eval $(keychain --agents gpg,ssh --eval --gpg2 --quiet bunker )

# VI Key bindings
export ZVM_VI_INSERT_ESCAPE_BINDKEY="jk"

# Other functions
function copy () 
{
	xsel -b < "$1"
}

function try ()
{
	until "$@"
	do
		sleep 1
	done
}

function movetokindle () 
{
    cp -v "$1" /run/media/zohar/Kindle/documents
}
