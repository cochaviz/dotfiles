# Dotfiles

[![zoharcochavi](https://circleci.com/gh/zoharcochavi/dotfiles.svg?style=shield)](https://app.circleci.com/pipelines/github/zoharcochavi/dotfiles)
> Probably overkill, but I like devops 🚀 

Contains various configuration files for Linux programs, among which:
- Kitty
- NeoVim (yes, I use both)
- Dunst
- Emacs (yes, I use both)

## Usage

`install.sh <TARGET_DIR> <NUKE>` will create symlinks of the files/folders in the `dotfiles` folder in the `TARGET_DIR`, and will create symlinks of the files/folders in `config` in `TARGET_DIR/.config`. 

>There are often more programs in the `.config` folder than you'd like to track changes for, which is why these are separate

By default `TARGET_DIR` will be the `$HOME` folder. The setting is mainly there for testing.
If you want to overwrite existing program configs and other dotfiles, this can be done by making the last argument `NUKE`. This will delete any conflicts when trying to make the symlinks.

## Installation

I recommend cloning the repo into a folder called `.dotfiles` in your directory
```bash
$ git clone https://www.github.com/zoharcochavi/dotfiles "$HOME"/.dotfiles
```

If you want to only use you own dot- and config files, you can do the following (assuming you've cloned into `$HOME/.dotfiles`). 

```bash
$ rm -r "$HOME"/.dotfiles/dotfiles/.* && rm -r "$HOME"/.dotfiles/config/*
```

Then _move_ all the required files into dotfiles and config. For example:

```bash
$ mv .fehbg .xinitrc "$HOME"/.dotfiles/dotfiles/
$ mv .config/nvim "$HOME"/.dotfiles/config
```

If you've succesfully copied your own dotfiles or just want to use mine (feel free to!):

```bash
$ "$HOME"/.dotfiles/install.sh
```

Remember that if you want to overwrite _all_ existing dotfiles, you can also

```bash
$ "$HOME"/.dotfiles/install.sh NUKE
```

However, do so only at your own risk! 
