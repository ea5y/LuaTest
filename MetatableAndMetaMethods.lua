Set = {}
Set.mt = {}
function Set.new(t)
	local set = {}
	setmetatable(set, Set.mt)
	for _, l in ipairs(t) do
		set[l] = true
	end
	return set
end

function Set.union(a,b)
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = true
	end
	for k in pairs(b) do
		res[k] = true
	end
	return res
end

function Set.intersection(a,b)
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = b[k]
	end
	return res
end

function Set.tostring(set)
	local s = "{"
	local sep = ""
	for e in pairs(set) do
		s = s .. sep .. e
		sep = ", "
	end
	return s .. "}"
end

function Set.print(s)
	print(Set.tostring(s))
end

--[[
s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
print(getmetatable(s1))
print(getmetatable(s2))


s3 = s1 + s2
Set.print(s3)


Set.print((s1 + s2)*s1)
--]]
Set.mt.__add = Set.union
Set.mt.__mul = Set.intersection
Set.mt.__le = function(a, b)
	for k in pairs(a) do
		if not b[k] then
			return false
		end
	end
	return true
end

Set.mt.__lt = function(a, b)
	return a <= b and not (b <= a)
end

Set.mt.__eq = function(a, b)
	return a <= b and b <= a
end

--[[
s1 = Set.new{2, 4}
s2 = Set.new{4, 10, 2}
print(s1 <= s2)
print(s1 < s2)
print(s1 >= s1)
print(s1 > s1)
print(s1 == (s2 * s1))
--]]
--
--

--===================TableIndex===================
--create a namespace
Window = {}
--create the prototype with default values
Window.prototype = {x = 0, y = 0, width = 100, height = 100}
--create a metatable
Window.mt = {}
--declare the constructor function
function Window.new(o)
	setmetatable(o, Window.mt)
	return o
end

--__index way 1
--[[
Window.mt.__index = function(table, key)
	return Window.prototype[key]
end
--]]
--__index way 2
Window.mt.__index = Window.prototype

function TestIndex()
	w = Window.new{x = 10, y = 20}
	print(w.width)
end

--===================TableDefault===================
--[[
function setDefault(t, d)
	local mt = {__index = function() return d end}
	setmetatable(t, mt)
end
--]]

local key = {}
local mt = {__index = function(t) return t[key] end}
function setDefault(t, d)
	t[key] = d
	setmetatable(t, mt)
end

function TestTableDefault()
	tab = {x = 10, y = 20}
	print(tab.x, tab.z)
	setDefault(tab, 0)
	print(tab.x, tab.z)
end

--======================WatchTable===================
t = {}
local _t = t
--create proxy
t = {}

--create metatable
local mt = {
	__index = function(t, k)
		print("*access to element " .. tostring(k))
		return _t[k]
	end,

	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		_t[k] = v
	end
}
setmetatable(t, mt)

function TestWatchTable()
	t[2] = 'hello'
	print(t[2])
end
--=====================WatchMultiTable===============
--create private index
local index = {}

--create metatable
local mt = {
	__index = function(t, k)
		print("*access to element " .. tostring(k))
		return t[index][k]
	end,

	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		t[index][k] = v
	end
}

function track(t)
	local proxy = {}
	proxy[index] = t
	setmetatable(proxy, mt)
	return proxy
end

function TestWatchMultiTable()
	t[2] = 'hello'
	print(t[2])
end

--======================ReadOnlyTable================
function readOnly(t)
	local proxy = {}
	local mt = {
		__index = t,
		__newindex = function(t, k, v)
			error("attempt to update a read-only table", 2)
		end
	}

	setmetatable(proxy, mt)
	return proxy
end

function TestReadOnlyTable()
	days = readOnly{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
	print(days[1])
	days[2] = "Noday"
end

