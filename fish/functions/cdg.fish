function cdg
	set -l current '.';
	while true
		set -l select (ls -F $argv $current | grep '/' | fzf --height 100% --prompt "SELECT DIRECTORY>" --preview "echo {} | xargs ls -G");
		cd $select;
		if test -z $select
			break;
		end
		if test $select = './'
                        break;
                end
		set -l current (pwd | xargs basename);
	end
end
