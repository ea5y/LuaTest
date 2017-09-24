function list_iter(t)
	local i = 0
	local n = #t
	return function()
		i = i + 1
		if i <= n then 
			return t[i]
		end
	end
end

function run()
	t = {10, 20, 30}
	iter = list_iter(t)
	while true do
		local elem = iter()
		if elem == nil then
			break
		end
		print(elem)
	end
end

function allwords()
	local line = io.read()
	local pos = 1
	return function()
		while line do
			local s,e = string.find(line, "%w+", pos)
			if s then
				pos = e + 1
				return string.sub(line, s, e)
			else
				line = io.read()
				pos = 1
			end
		end
		return nil
	end
end

function ErrorTest()
	print "enter a number:"
	n = io.read("*number")
	if not n then 
		error("invalid input")
	end
end
