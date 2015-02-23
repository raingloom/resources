--For debug use only


printer=outputChatBox
printSeparator="\t"
--Provides the standard Lua printing functionality
--Unlike Lua's print, it also returns all arguments, this way you can easily insert it into any code for debugging, without affecting the variable assignment. This way you can do the C++ of cout<<(x=y)
--Example: a=print(math.abs(-5))
function print(...)
	local arg={...}
	local n=arg.n or #arg
	local buf={}
	for i=1,n do
		table.insert(buf,tostring(arg[i]))
	end
	printer(table.concat(buf,printSeparator))
	return ...
end
