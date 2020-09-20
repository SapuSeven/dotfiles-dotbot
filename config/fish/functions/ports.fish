# Defined in - @ line 1
function ports --description 'alias ports=lsof -i -P -n | grep LISTEN'
	lsof -i -P -n | grep LISTEN $argv;
end
