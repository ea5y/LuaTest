--[[
local count = 0

function Entry()
	count = count + 1
end
dofile("lua_data.conf")
print("number of entries: " .. count)
--]]
 local personInfo = {}
 function Entry(b)
 	if b.name then
		personInfo[b.name] = true
	end
 end

dofile("lua_data.conf")
for name in pairs(personInfo) do
	print(name)
end
