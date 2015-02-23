--[[--
    Converts a multiline string into a matrix of characters.
    Any line shorter than the longest line will be padded with a space or the optional parameter 'p'.
    @param str The string to convert
    @param [p] A character to use for filling out short lines
    @return A matrix of characters
]]
function LinesToMatrix(str,width,padding)
    padding=padding or ' '
    local mat={}
    local y,x=0,0
    local line
    local longest=0
    --Iterate lines, trim newline character
    for l in str:gmatch"(.-)\n" do
		for substr in matchn(l,width) do
			y=y+1
			if x>longest then longest=x end
			x=0
			line={}
			mat[y]=line
			--Iterate characters
			for c in substr:gmatch"." do
				if c=='\n' then break end
				x=x+1
				line[x]=c
			end
		end
    end
    if x>longest then longest=x end
    ---[[
    --Fit lines to match matrix size
    for y=1,#mat do
		line=mat[y]
		for x=width,#line+1,-1 do
			line[x]=padding
		end
	end
    --]]
    return mat
end

--helper function to wrap lines by length
function matchn(str,n)
	local s,e,l=-n+1,0,#str
	local sub=str.sub
	return function()
		if e>=l then
			return
		else
			s=s+n
			e=e+n
			return sub(str,s,e)
		end
	end
end
