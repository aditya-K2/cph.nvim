local function join(inputTable)
	local s = ""
	for i = 1, #inputTable do
		s = s .. inputTable[i]
	end
	return s
end

return {
	join = join;
}
