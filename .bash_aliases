#!/bin/sh

_completion_loader git


__define_git_completion () {
  eval "
      _git_$2_shortcut () {
          COMP_LINE=\"git $2\${COMP_LINE#$1}\"
          let COMP_POINT+=$((4+${#2}-${#1}))
          COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\")
          let COMP_CWORD+=1
          local cur words cword prev
         _get_comp_words_by_ref -n =: cur words cword prev
         _git_$2
      }
  "
}

__gitshortcut () {
    type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2
    alias $1="git $2 $3"
    complete -o default -o nospace -F _git_$2_shortcut $1
}



# GIT
alias gda="git branch | grep -v "master" | xargs git branch -d"
alias gDa="git branch | grep -v "master" | xargs git branch -D"
#alias gp="git push"
__gitshortcut  gp       push
__gitshortcut  gpu       push -u
alias gpo="git push origin"
alias gpom="git push origin master"
alias gpod="git push origin devel"
#alias gl="git pull"
__gitshortcut  gl       pull
alias glo="git pull origin"
alias glom="git pull origin master"
alias glod="git pull origin devel"
#alias glr="git pull --rebase"
__gitshortcut  glr      pull --rebase
#alias glro="git pull --rebase origin"
__gitshortcut  glro     pull '--rebase origin'
#alias glrom="git pull --rebase origin master"
__gitshortcut  glrom    pull '--rebase origin master'
#alias glrod="git pull --rebase origin devel"
__gitshortcut  glrod    pull '--rebase origin devel'
#alias gc="git commit"
__gitshortcut  gc       commit
#alias gca='git commit -a'
__gitshortcut  gca      commit -a
#alias gco="git checkout"
__gitshortcut  gco      checkout
alias gcom="git checkout master"
alias gcod="git checkout devel"
alias gapf="git commit --amend --no-edit -n  && git push -f"
#alias gb="git branch"
__gitshortcut  gb       branch
#alias gm="git merge"
__gitshortcut  gm       merge
#alias gs="git status"
__gitshortcut  gs       status
#alias gd="git diff"
__gitshortcut  gd       diff
#alias ga="git add"
__gitshortcut  ga       add
#alias gf="git fetch"
__gitshortcut  gf       fetch
alias gfp="git fetch --prune"
#alias gr='git reset'
__gitshortcut  gr       reset
#alias gst="git stash"
__gitshortcut  gst      stash
alias gstp="git stash pop"
alias gmm="git merge master"
alias gmd="git merge devel"
alias grs="git reset --soft"
alias grh="git reset --hard"

alias ghfs="git hub-feature start"
alias ghfu="git hub-feature update"
alias ghfp="git hub-feature publish"
alias ghfr="git hub-feature review"
alias ghff="git hub-feature finish"
alias gstrp="echo '======= Stashing... =======' && gst && echo '======= PULL Rebasing... =======' && glr && echo '======= Stash Popping... =======' && gstp"
#alias hpr="hub pull-request -a emoreth"
alias ppr="gp && hpr && pr"


# Docker
alias dka='docker kill $(docker ps -q)'
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dr="docker run"
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcb="docker compose build"
alias dcbn="docker compose build --no-cache"


# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kx="kubectx"
alias ks="kubens"
alias kgp="k get pods"
alias kgpy="k get pods -o yaml"
alias kgs="k get services"
alias kgsy="k get services -o yaml"
alias kgd="k get deployments"
alias kgdy="k get deployments -o yaml"
alias kge="kubectl get events --sort-by=.metadata.creationTimestamp "
alias kdp="k delete pod --wait=0 "

htopid () {
  htop -p $(ps -ef | awk -v proc=$1 'BEGIN{pids[proc]=1;printf "%s",proc} {if(pids[$3]==1){printf ",%s",$2; pids[$2]=1}}')
}

alias dummypod='kubectl run -i --tty --rm debug --image=debian --restart=Never -- bash'
