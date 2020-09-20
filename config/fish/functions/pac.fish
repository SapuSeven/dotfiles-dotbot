# Defined in - @ line 1
function pac --description 'alias pac=sudo pacman --noconfirm'
	sudo pacman --noconfirm $argv;
end
