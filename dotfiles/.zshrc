# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/zohar/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
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
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR=nvim
export VISUAL=nvim

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases
alias bspwmrc="nvim $HOME/.config/bspwm/bspwmrc"
alias sxhkdrc="nvim $HOME/.config/sxhkd/sxhkdrc"
alias mkgrubcfg="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias launchplayer="sudo modprobe -a vmw_vmci vmmon && sudo systemctl start vmware.service && sudo systemctl start vmware-networks-server.service && sudo vmplayer /home/zohar/Documents/Study/y2/q4/SP/doc/Lubuntu\ 20.04.M.1.2/Lubuntu\ 20.04/Lubuntu\ 20.06\ LTS\ 64-bit.vmx &> /dev/null & ; disown"
alias logout="loginctl kill-user zohar"
alias kssh="kitty +kitten ssh"
alias startworkenv="launchplayer && kssh root@193.168.0.156"
alias svenv="source ./venv/bin/activate"

# Exports
export XSECURELOCK_IMAGE_PATH=/home/zohar/Pictures/wallpaper.jpg

# SSH keys 
eval $(ssh-agent -s) &> /dev/null
eval $(keychain --eval --quiet bunker)

# VI Key bindings
export ZVM_VI_INSERT_ESCAPE_BINDKEY="jk"

# Other functions
function copy () 
{
	cat $1 | xsel -i
}
