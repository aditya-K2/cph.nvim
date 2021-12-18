local function GetFormattedString(str, width, char)
	return str .. string.rep(char, math.abs(width-#str))
end

local function join(inputTable)
	local s = ""
	for i = 1, #inputTable do
		s = s .. GetFormattedString(inputTable[i], T_WIDTH - 1, " ") .. "\n"
	end
	return s
end

local function GenerateBufferContent(inputTable)
	local s = ""
	for i = 1, #inputTable do
		if inputTable[i].input ~= nil then
			s = s .. "TESTCASE " .. tostring(i) .. "\n\n\n"
			s = s .. "INPUT\n\n"
			s = s .. inputTable[i].input
			s = s .. "\n\n"
		end
		if inputTable[i].output ~= nil then
			s = s .. "EXPECTED_OUTPUT\n\n"
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
