function room1()
	print("In room1:\ncontinue to:")
	local move = io.read()
	if move == "south" then
		return room3()
	elseif move == "east" then
		return room2()
	else
		print("invalid move")
		return room1()
	end
end

function room2()
	print("In room2:\ncontinue to:")
	local move = io.read()
	if move == "south" then
		return room4()
	elseif move == "west" then
		return room1()
	else
		print("invalid move")
		return room2()
	end
end

function room3()
	print("In room3:\ncontinue to:")
	local move = io.read()
	if move == "north" then
		return room1()
	elseif move == "east" then
		return room4()
	else
		print("invalid move")
		return room3()
	end
end

function room4()
	print("congratilations!")
end
