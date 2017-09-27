--simple mode
--Input
file = io.open("Error.lua","r")
io.input(file)
print(io.read())
io.close(file)

--Output
file = io.open("Error.lua","a")
io.output(file)
io.write("-- Error.lua")
io.close(file)

