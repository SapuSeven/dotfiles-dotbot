# Defined in - @ line 1
function ulocate --description 'alias ulocate=sudo updatedb && locate'
	sudo updatedb && locate $argv;
end
