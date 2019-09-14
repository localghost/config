function fish_right_prompt
  set -g __fish_git_prompt_showdirtystate on
  set -g __fish_git_prompt_showcolorhints on
  # set -g __fish_git_prompt_showstashstate on
  set -g __fish_git_prompt_showupstream informative
  # set -g __fish_git_prompt_show_informative_status on
  
  echo (__fish_git_prompt) (date '+%H:%M:%S')
end
