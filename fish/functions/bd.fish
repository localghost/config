function bd
  if test (count $argv) -eq 0
    cd /work/bigdata/bigdata
  else
    cd /work/bigdata/bigdata$argv[1]
  end
end
