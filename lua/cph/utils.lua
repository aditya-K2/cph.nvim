local function join(inputTable)
	local s = ""
	for i = 1, #inputTable do
		s = s .. inputTable[i]
	end
	return s
end

local function GenerateBufferContent(inputTable)
	local s = ""
	for i = 1, #inputTable do
		if inputTable[i].input ~= nil then
			s = s .. " TESTCASE " .. tostring(i) .. "\n\n\n"
			s = s .. " INPUT\n"
			s = s .. inputTable[i].input
			s = s .. "\n\n"
		end
		if inputTable[i].output ~= nil then
			s = s .. " EXPECTED OUTPUT\n"
			s = s .. inputTable[i].output
			s = s .. "\n\n"
		end
	end
	return s
end

return {
	join = join,
	GenerateBufferContent = GenerateBufferContent,
}
