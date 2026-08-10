#######################
### GitLab (glab) ###
#######################

if ! command -v glab >/dev/null; then
  return 0
fi

alias mrc='glab mr create'
alias mrv='glab mr view'
alias mrl='glab mr list'
alias mrd='glab mr diff'
alias mrm='glab mr merge'
alias il='glab issue list'
alias ic='glab issue create'
alias iv='glab issue view'
alias ci='glab ci view'
alias cil='glab ci list'
alias pipe='glab ci trace'