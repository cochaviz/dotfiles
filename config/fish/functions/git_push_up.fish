function git_push_up --wraps=git\ push\ --set-upstream\ origin\ \'dialog-manager\' --description alias\ git_push_up=git\ push\ --set-upstream\ origin\ \'dialog-manager\'
  git push --set-upstream origin 'dialog-manager' $argv; 
end
