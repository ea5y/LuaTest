function ErrorTest()
	print "enter a number:"
	n = io.read("*number")
	if not n then 
		error("invalid input")
	end
end

function ErrorAssert()
	print "enter a number:"
	n = assert(io.read("*number"), "invalid input")
end

function OpenFileNormal()
	local file, msg
	repeat
		print "enter a file name:"
		local name = io.read()
		if not name then
			return 
		end
		file, msg = io.open(name, "r")
		if not file then
			print(msg)
		end
	until file
end

function openFileAssert()
	file = assert(io.open("no", "r"))
end

function openFileNoAssert()
	file = io.open("no", "r")
end

function pcallTest()
	local status, err = pcall(function() error({code=121}) end)
	print(status, err.code)
end


-- Error.lua