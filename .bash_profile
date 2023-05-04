source "$HOME/.bash_aliases"

export EDITOR=vim
export CLICOLOR=true
export LSCOLORS=Exfxcxdxbxegedabagacad
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTFILESIZE=2000000

export COMPOSE_DOCKER_CLI_BUILD=1 # improves cache hits by using the CLI docker for building
export DOCKER_BUILDKIT=1 # improves build speed by using docker's buildkit engine


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# source /usr/share/bash-completion/completions/git


OH_MY_BASH_DIR=".oh-my-bash"
DIR="$HOME/$OH_MY_BASH_DIR"
FROM_DIR="/tmp/.dotfilerepo"
# look for empty dir
if [ -d "$DIR" ]
then
	if ! [ "$(ls -A $DIR)" ]; then
        #echo "$DIR is Empty"
        CURRENT_DIR=$PWD
        cd $FROM_DIR
        git submodule init
        git submodule update
        sudo cp -r $FROM_DIR/$OH_MY_BASH_DIR $HOME
        cd $CURRENT_DIR
# 	else
#         echo "Take action $DIR is not Empty"
	fi
# else
# 	echo "Directory $DIR not found."
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
