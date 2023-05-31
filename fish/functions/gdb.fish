function gdb
	set_color normal; git diff (git rev-parse $argv[1]) (git rev-parse (git rev-parse (git symbolic-ref --short HEAD)))
end
