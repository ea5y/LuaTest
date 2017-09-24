--[[
function producer()
	while true do
		local x = io.read()
		send(x)
	end
end

function consumer()
	while true do
		local x = receive()
		io.write(x, "\n")
	end
end
--]]

function receive(prod)
	local status, value = coroutine.resume(prod)
	return value
end

function send(x)
	coroutine.yield(x)
end

function producer()
	return coroutine.create( function()
		--while true do
		for i = 1, 10 do
			local x = io.read()
			send(x)
		end
		--end
	end)
end

function filter(prod)
	return coroutine.create(function()
		local line = 1
		--while true do
		for i = 1, 10 do
			local x = receive(prod)
			x = string.format("%5d %s", line, x)
			send(x)
			line = line + 1
		end
		--end
	end)
end

function consumer(prod)
	--while true do
	for i = 1, 10 do
		local x = receive(prod)
		io.write(x, "\n")
	end
	--end
end

--=======================================
--[[
function permgen(a, n)
	if n == 0 then
		printResult(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n]
			permgen(a, n - 1)
			a[n], a[i] = a[i], a[n]
		end
	end
end
--]]

function printResult(a)
	for i, v in ipairs(a) do
		io.write(v, " ")
	end
	io.write("\n")
end

function permgen(a, n)
	if n == 0 then
		coroutine.yield(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n]
			permgen(a, n - 1)
			a[n], a[i] = a[i], a[n]
		end
	end
end

function perm(a)
	local n = #a
	--[[
	local co = coroutine.create(function() permgen(a, n) end)
	return function()
		local code, res = coroutine.resume(co)
		return res
	end
	--]]
	return coroutine.wrap(function() permgen(a, n) end)
end

--==============================================
--use coroutine load file
require "socket"
function download(host, file)
	local c = assert(socket.connect(host, 80))
	local count = 0
	c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
	while true do
		local s, status = receive(c)
		count = count + string.len(s)
		if status == "closed" then break end
	end
	c:close()
	print(file, count)
end

function receive(connection)
	return connection:receive(2^10)
end
