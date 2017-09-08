alias l="ls --color -p"
alias ll="l -l -h"
alias la="l -la -h"
# alias ps="ps -u $USER -o pid,ppid,rss,vsize,pcpu,pmem,nice,cmd,user"
alias ps="ps ux"
alias now="date | cut -f 2,3,4 -d' ' | sed 's, ,_,g; s,:,.,g'"
alias xterm="xterm -fa 'DejaVu Sans Mono' -fs 10"
alias du="du -s -h"
alias xterm="xterm -fg white -bg black"
alias gitkdiff="git difftool -t tkdiff"

HOST=$(uname -n) # portable for MacOSX
export EDITOR=vim
export LOCALDIR="$HOME/local/$HOST"
export ARCH="linux2"
export LC_ALL=
export COMP_ARCH="yes"
if [[ $(uname -s) != "Darwin" ]]
then
  LOCAL_PATH="/home/$USER/local"
  export JAVA_HOME="$HOME/opt/jdk"
  export PATH="$LOCALDIR/bin:$LOCAL_PATH/bin:$JAVA_HOME/bin:$PATH"
  export CLASSPATH="$JAVA_HOME/lib:$CLASSPATH"

  export PATH=$HOME/local/opt/cmake/bin:$PATH
else
 export LICOLORS=1
 export LSCOLORS=ExFxBxDxCxegedabagacad
 alias ls="ls -GFh"
 alias l="ls"
 alias ll="ls -l"
 alias la="ls -la"
fi


export HEDITOR=vim
if [[ $(uname -m | grep 64) && -d "/opt/intel/bin" ]]
then
  export PATH="/opt/intel/inspector_xe:/opt/intel/bin:/opt/intel/inspector_xe/bin64:$PATH"
  [[ $(which inspxe-vars.sh) ]] && source inspxe-vars.sh 2>&1 >/dev/null && \
                                   source /opt/intel/vtune_amplifier_xe/amplxe-vars.sh
fi 2>&1 > /dev/null

umask 0027

quiet()
{
  eval "$* &> /dev/null &"
}

locallibs()
{
  # first clean up the variable
  LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | tr : '\n' | grep -v "$HOME/local" | tr '\n' : | sed 's,:$,,')

  [[ ! -d "$HOME/local/$(uname -n)/lib" ]] && return 1
  export LD_LIBRARY_PATH="$HOME/local/$(uname -n)/lib:$HOME/local/$(uname -n)/lib64:$LD_LIBRARY_PATH"
  [[ -d "$HOME/local/lib64" ]] && export LD_LIBRARY_PATH="$HOME/local/lib64:$LD_LIBRARY_PATH"
}

localbins()
{
  PATH=$(echo $PATH | tr : '\n' | grep -v "$HOME/local" | tr '\n' : | sed 's,:$,,')
  [[ ! -d "$HOME/local/$(uname -n)/bin" ]] && return 1
  export PATH="$HOME/local/bin:$HOME/local/$HOST/bin:$PATH"
}

anaconda3()
{
  ANACONDA=$HOME/opt/anaconda3
  export PATH=$ANACONDA/bin:$PATH
  export LD_LIBRARY_PATH=$ANACONDA/lib:$LD_LIBRARY_PATH
  export PKG_CONFIG_PATH=$ANACONDA/lib/pkgconfig:$PKG_CONFIG_PATH
  export PYTHONPATH=$ANACONDA/lib/python3.5:$PYTHONPATH
}

# hbreakon()
# {
#   for line in $(grep -Rn $1 $HALCONROOT/source/hlib | cut -f 1,2 -d:)
#   do
#     echo "b $line"
#   done > breakpoints.gdb
# }

export PKG_CONFIG_PATH=$LOCALDIR/lib64/pkgconfig:$LOCALDIR/lib/pkgconfig:$PKG_CONFIG_PATH
export MANPATH=$LOCALDIR/man:$MANPATH
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[01;31m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '

if [[ $(uname -m | grep 64) ]]
then
  export LD_LIBRARY_PATH=$HOME/local/lib64:$LOCALDIR/lib64/:$LOCALDIR/lib:$LD_LIBRARY_PATH
else
  export LD_LIBRARY_PATH=$LOCALDIR/lib:$LD_LIBRARY_PATH
fi

# avoid problems in OSX
if [[ $(uname -s) == "Linux" ]]
then
  export NODE_PATH=$HOME/node_modules
  export PATH=$MILFROOT/bin:$PATH

  export PATH=$HOME/.local/bin:$PATH
  export PYTHONPATH="$HOME/.local/lib/python2.7/site-packages":$PYTHONPATH

  # powerline for the shell
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  alias tmux="tmux -2"
else
  alias ls="ls -Gp"
fi

alias cgrep="grep --color=always"
alias cless="less -R"


function set_clang()
{
  VERSION=$1
  CLANGROOT=/soft/dist/clang-${VERSION:-4.0}-x64
  export PATH=$CLANGROOT/bin:$PATH
  export LD_LIBRARY_PATH=$CLANGROOT/lib:$LD_LIBRARY_PATH
}

# tmux
refresh_env()
{
  if [[ ! -z "$TMUX" ]]
  then
    export $(tmux show-environment | grep "^DISPLAY")
    export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
  fi
}
