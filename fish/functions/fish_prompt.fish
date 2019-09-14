function fish_prompt
  if set -q VIRTUAL_ENV
    set_color ffa500
    echo -n "("(basename $VIRTUAL_ENV)") "
    set_color normal
  end
  echo (id -un)@(hostname):(set_color blue)(prompt_pwd)(set_color normal) '> ' 
end
