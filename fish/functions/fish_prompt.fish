function fish_prompt
  echo (date '+%H:%M:%S') (id -un)@(hostname):(pwd)
  echo '> '
end
