ModuleTest = {}

ModuleTest.constant = "This is a constant"

function ModuleTest.func1()
	io.write("This is a public func!\n")
end

local function func2()
	print("This is a private func!\n")
end

function ModuleTest.func3()
	func2()
end

return ModuleTest

