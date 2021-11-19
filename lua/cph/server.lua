local metadata
local json = require("cph.json")
local http_server = require "http.server"
-- local json = require "json"

local function reply(_server, stream) -- luacheck: ignore 212
	metadata = assert(stream:get_body_as_string())
	-- metadataTable = json.parse(req_body)
	coroutine.yield()
end

local myserver

local function Listen()
	-- Manually call :listen() so that we are bound before calling :localname()
	assert(myserver:listen())
	-- Start the main server loop
	assert(myserver:loop())
end

function Start()
	myserver = assert(http_server.listen {
		host = "localhost";
		port = 10043;
		onstream = reply;
		onerror = function(_server, context, op, err, errno) -- luacheck: ignore 212
			local msg = op .. " on " .. tostring(context) .. " failed"
			if err then
				msg = msg .. ": " .. tostring(err)
			end
			assert(io.stderr:write(msg, "\n", errno, _server))
		end;
	})
	local co = coroutine.create(Listen)
	coroutine.resume(co)
	myserver:close()
end

function GetInfo()
	return json.parse(metadata)
end

return {
	Start = Start,
	GetInfo = GetInfo
}
