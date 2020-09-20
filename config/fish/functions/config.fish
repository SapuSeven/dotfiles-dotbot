# Defined in - @ line 1
function config --description 'alias config=/usr/bin/git --git-dir=/home/paul/.dotfiles --work-tree=/home/paul'
	/usr/bin/git --git-dir=/home/paul/.dotfiles --work-tree=/home/paul $argv;
end
