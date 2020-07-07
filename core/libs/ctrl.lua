--[[ Copyright 2017 raidho36/rcoaxil <coaxilthedrug@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

--[[ BASIC USE:

Being designed as robust library, basic usage is very simple:
* define "inputpressed", "inputreleased" and "inputmoved" functions on the ctrl instance
* call "bind" function for inputs you need
* call "hookup" function to link update methods to lÃ¶ve's standard callbacks

The input callbacks are called with three arguments:
* ctrl instance that detected an input
* input name
* input value
It will not be called for user input that's not bound to anything.

The "bind" function accepts three arguments:
* input name
* input address
Input name can be any string. Input address is a list of input locations
	e.g. { "keyboard", "space" } or { "gamepad", "xbox", "button", "x" }

Example Code:
local ctrl = require ( 'ctrl' ) ( )
function ctrl:inputpressed ( name, value ) print ( "pressed", name, value ) end
function ctrl:inputreleased ( name, value ) print ( "released", name, value ) end
function ctrl:inputmoved ( name, value ) print ( "moved", name, value ) end
ctrl:bind ( "fire", { "keyboard", "space" } )
ctrl:bind ( "fire", { "joystick", "default", "button", 1 } )
ctrl:bind ( "fire", { "mouse", "left" } )
ctrl:hookup ( )

]]

--[[ REFERENCE MANUAL:

ctrl ( ), ctrl.new ( )
	creates and returns new input handler instance
ctrl:hookup ( )
	hooks up input handlers to leech off of default lÃ¶ve input callbacks
ctrl:bind ( name, input, [options] )
	binds specified input to an input name
	* name - input name to bind to
	* input - ctrl input address to bind
	* options (optional) - options table, can contain following fields:
		* mapper (optional) - table describing a raw value mapper
			* func - callback mapper function, returns mapped raw value
			* args (optional) - callback function arguments table
		* filter (optional) - table describing a value filter
			* func - callback filter function, returns filtered value
			* args (optional) - callback function arguments table
		* events (optional) - table containing list of events description tables. Each table contains:
			* trigger - callback trigger function, returns true if event should be triggered
			* handler - callback handler function, called if event is triggered
			* args (optional) - callback trigger arguments table
ctrl:unbind ( [name], [input] )
	unbinds specified inputs
	* name (optional) - input name to unbind
	* input (optional) - ctrl input address to unbind
	if called without arguments, unbinds everything
	if called without input address, unbinds everything bound to a specific name
	if called without name, unbinds everything bound to a specific address
	input address can be partial address, then it acts like a filter, unbinds everything that matches
ctrl:grab ( [callback], [autobind], [filters] )
	starts tracking input devices for any activity, grabs the first one that changes
	* callback (optional) - function that will be called when activity is detected
		shall return true if it should ignore current input and track the next one
		called with the following arguments:
			* input - ctrl input address table
			* name - the autobind argument unmodified
	* autobind (optional) - string input name to which it would automatically bind anything it finds
	* filters (optional) - list of ctrl input addresses that it will match against during tracking
ctrl:getBindings ( [name], [input] )
	finds and returns list of all input addresses bound to a specified input name
	* name (optional) - name to look bindings for
	* input (optional) - ctrl input path to look in
	if name is not passed, finds all bindings
	input can be partial path, then it acts as a filter
	list entries have the following format:
		* name - string name of the input
		* input - ctrl input address table
		* options - table of input options (mapper, filter, events)
ctrl:isUp ( name )
ctrl:wasUp ( name )
	returns true if value of an input is under 0.25
	* name - input name to look for
ctrl:isDown ( name )
ctrl:wasDown ( name )
	returns true if value of an input is above 0.75
	* name - input name to look for
ctrl:getValue ( name )
ctrl:getLastValue ( name )
	returns value of an input
	* name - input name to look for
ctrl:resetValues ( )
	resets all values to 0
	focusing out and in a window combined with some ways of input handling can cause input glitches,
	resetting all values solves that problem
ctrl:mapDevice ( device, value )
	maps userdata or table device to a string, number or boolean value
	* device - the input device userdata, table or any other value by which it's referenced
	* value - string, number or boolean value by which its input would be addressed
	should be used with joysticks and gamepads and other devices without persistent ID
ctrl:getMapping ( device )
	returns previously mapped value for this device, defaults to "default"
	* device - the input device to look for
ctrl:setGamepadMapping ( joy, control, input )
	mirros love.joystick.setGamepadMapping, but provides seamless integraiton with the library
	* joy - lÃ¶ve Joystick object to map
	* control - lÃ¶ve Gamepad control (button, hat, axis)
	* input - ctrl joystick input path table
ctrl:getGamepadMapping ( joy, control )
	mirros love.joystick.getGamepadMapping, but provides seamless integraiton with the library
	* joy - lÃ¶ve Joystick object to get mapping from
	* control - lÃ¶ve Gamepad control (button, hat, axis)
	returns ctrl joystick input address table for selected Gamepad control
ctrl:addInputs ( input, new )
	adds new values to the valid inputs list
	* input - ctrl input path to add to
	* new - list of additional valid inputs, can contain a metatable
ctrl:handleUpdate ( input, raw, ... )
	processes input event and dispatches callbacks
	* input - ctrl input address table
	* raw - raw value
	* vararg - any additional values, will be passed into raw mapper function
ctrl:addTriggerFunction ( name, func )
	adds new trigger function to the list
	* name - string name of new event trigger function
	* func - callback function, shall return true if event should be triggered
		called with the following arguments:
			* current value
			* previous value
			* function arguments table
ctrl:addFilterFunction ( name, func )
	adds new filter function to the list
	* name - string name of new value filter function
	* func - callback function, shall return filtered value
		called with the following arguments:
			* time elapsed since last call
			* raw input value
			* previous filtered value
			* function arguments table
ctrl:addMapperFunction ( name, func )
	adds new raw value mapper function to the list
	* name - string name of new raw value mapper function
	* func - callback function, shall return mapped raw value
		called with the following arguments:
			* raw value
			* previous mapped value
			* function arguments table
			* vararg passed into input event handler function
ctrl:saveData ( [filename] )
	saves all internal data to a file, returns data string if file is not provided
	* filename (optional) - filename to store data in
ctrl:loadData ( filename )
	loads data from a file or a string
	* filename - filename to load data from, or data string
ctrl:handleUpdate ( dt )
ctrl:handleKeypressed ( key, code, repeated )
ctrl:handleKeyreleased ( key, code, repeated )
ctrl:handleMousepressed ( x, y, button, touch )
ctrl:handleMousereleased ( x, y, button, touch )
ctrl:handleMousemoved ( x, y, dx, dy, touch )
ctrl:handleWheelmoved ( x, y )
ctrl:handleGamepadaxis ( joy, axis, value )
ctrl:handleGamepadpressed ( joy, button )
ctrl:handleGamepadreleased ( joy, button )
ctrl:handleJoystickaxis ( joy, axis, value )
ctrl:handleJoystickhat ( joy, hat, dir )
ctrl:handleJoystickpressed ( joy, button )
ctrl:handleJoystickreleased ( joy, button )
ctrl:handleJoystickadded ( joy )
ctrl:handleJoystickremoved ( joy )
	LÃ–VE input event handlers. To be called manually as appropriate if CTRL instance is not "hooked" up.

Input address listing:
	* "keyboard"
		* all standard keyboard constants
	* "mouse"
		* "x", "y", "wheelx", "wheely", "left", "right", "middle"
		* 4, 5, 6, etc.
	* "gamepad"
		* any existing mapping for a Joystick
			* "axis"
				* "leftx", "rightx", "lefty", "righty", "triggerleft", "triggerright"
			* "button"
				* "a", "b", "x", "y", "back", "guide", "start",
				* "leftstick", "rightstick", "leftshoulder", "rightshoulder"
			* "hat"
				* "up", "down", "left", "right"
	* "joystick"
		* any existing device mapping for a Joystick
			* "axis"
				* 1, 2, 3, etc.
			* "button"
				* 1, 2, 3, etc.
			* "hat"
				* 1, 2, 3, etc.
					* "up", "down", "left", "right"
]]

--[[ CHANGELOG:

* 1.0.0 initial release
* 1.0.1
	* added basic use demo
	* bind events: if none provided uses defaults, doesn't do anything if "none" provided
	* hat directions renamed to "up", "down", "left", "right"
	* fixed broken getValue, isUp, isDown
	* fixed input mappers overwriting all raws on their input
* 1.0.2
	* added bind options demo
	* added input options screen demo
	* added "remap" default mapper
	* autobind name is now passed into input grab callback
	* getValue now returns 0 for unbound inputs
	* fixed broken unbind function
* 1.0.3
	* made input autobind filters accept wildcards (nil)
	* fixed broken addInputs function
* 1.0.3.1
	* added wasUp, wasDown, getLastValue
]]

local Ctrl = setmetatable ( { }, { __call = function ( class, ... ) return class.new ( ... ) end } )
Ctrl.__index = Ctrl

local function copy ( t, meta )
	if not t then return nil end
	local output = { }
	for k, v in pairs ( t ) do
		if type ( v ) == "table" then
			output[ k ] = copy ( v )
		else
			output[ k ] = v
		end
	end
	if meta then
		setmetatable ( output, getmetatable ( t ) )
	end
	return output
end

local function reverse ( t )
	for i = 1, #t / 2 do
		t[ i ], t[ #t - i + 1 ] = t[ #t - i + 1 ], t[ i ]
	end
	return t
end

local function lookupify ( t )
	local o = { }
	for k, v in pairs ( t ) do
		o[ v ] = k
	end
	return o
end

local function prune ( t, k )
	for i = #t[ k ], 1, -1 do
		if type ( t[ k ][ i ] ) == "table" then
			prune ( t[ k ], i )
		end
	end
	for kk, vv in pairs ( t[ k ] ) do
		if type ( vv ) == "table" then
			prune ( t[ k ], kk )
		end
	end

	local count = 0
	for _, __ in pairs ( t[ k ] ) do
		count = count + 1
	end
	if count == 0 then
		if type ( k ) == "number" then
			table.remove ( t, k )
		else
			t[ k ] = nil
		end
	end
end

local function unbind ( self, from, name )
	if type ( from[ 1 ] ) == "table" and from[ 1 ].name then
		for i = #from, 1, -1 do
			if not name or from[ i ].name == name then
				local r = table.remove ( from, i )
				for f = 1, #self._filterlist do
					if self._filterlist[ f ] == r then
						table.remove ( self._filterlist, f )
					end
				end
			end
		end
	else
		for k, v in pairs ( from ) do
			unbind ( self, v, name )
		end
	end
end

local function handle ( ctrl, input, raw, ... )
	-- normal input handling mode
	if not ctrl.tograb then
		-- compute raw data storage slot
		local data = ctrl.inputs
		for i = 1, #input do
			data = data[ input[ i ] ]
			if not data then return end
		end

		for i = 1, #data do
			local entry = data[ i ]
			local lastraw = ctrl.raws[ entry ] or 0
			local newraw = raw
			-- apply input mapping
			if entry.mapper then
				local mapper = entry.mapper.func
				mapper = type ( mapper ) == "function" and mapper or ctrl.mappers[ mapper ]
				newraw = mapper ( raw, lastraw, entry.mapper.args, ... )
			end
			ctrl.raws[ entry ] = newraw

			-- only immediately set input values and trigger events for entries that have no filters
			if not entry.filter then
				ctrl.values[ entry.name ] = newraw
				if entry.events then
					for _, event in pairs ( entry.events ) do
						local trigger = event.trigger
						trigger = type ( trigger ) == "function" and trigger or ctrl.triggers[ trigger ]
						if trigger ( newraw, lastraw, event.args ) then
							local handler = event.handler
							handler = type ( handler ) == "function" and handler or ctrl[ handler ]
							handler ( ctrl, entry.name, newraw )
						end
					end
				end
			end
		end
	else
		-- filter whitelisted inputs
		if ctrl.tograb.filter then
			local filterpass = false
			for i = 1, #ctrl.tograb.filter do
				local filter = ctrl.tograb.filter[ i ]
				for j = 1, #filter do
					if filter[ j ] and input[ j ] ~= filter[ j ] then break end
					if j == #filter then filterpass = true end
				end
			end
			if not filterpass then return end
		end

		-- create raw data storage slot
		local data = ctrl.inputs
		for i = 1, #input do
			if not data[ input[ i ] ] then data[ input[ i ] ] = { } end
			data = data[ input[ i ] ]
		end
		if not data[ 1 ] then data[ 1 ] = { } end
		data = data[ 1 ]

		-- make mouse less sensitive to input grabbing
		if input[ 1 ] == "mouse" and ( input[ 2 ] == "x" or input[ 2 ] == "y" ) then
			raw = raw / 100
		end

		-- record input state the first time it changes, then keep it for the reference
		if not ctrl.raws[ data ] then ctrl.raws[ data ] = raw end

		-- grab input
		if math.abs ( ctrl.raws[ data ] - raw ) > 0.5 then
			-- returning "true" from callback drops currently grabbed input and continues grabbing
			if not ctrl.tograb.callback or not ctrl.tograb.callback ( input, ctrl.tograb.autobind ) then
				prune ( ctrl, "inputs" )
				ctrl.inputs = ctrl.inputs or { }
				ctrl.raws = { }
				if ctrl.tograb and ctrl.tograb.autobind then ctrl:bind ( ctrl.tograb.autobind, input ) end
				ctrl.tograb = nil
			else
				ctrl.raws[ data ] = raw
			end
		end
	end
end

local function filter ( ctrl, dt )
	for i = 1, #ctrl._filterlist do
		entry = ctrl._filterlist[ i ]
		local lastvalue = ctrl.values[ entry.name ]
		local filter = entry.filter.func
		filter = type ( filter ) == "function" and filter or ctrl.filters[ filter ]
		local value = filter ( dt, ctrl.raws[ entry ] or 0, ctrl.values[ entry.name ], entry.filter.args )
		ctrl.values[ entry.name ] = value
		-- trigger attached entry events
		if entry.events then
			for _, event in pairs ( entry.events ) do
				local trigger = event.trigger
				trigger = type ( trigger ) == "function" and trigger or ctrl.triggers[ trigger ]
				if trigger ( value, lastvalue, event.args ) then
					local handler = event.handler
					handler = type ( handler ) == "function" and handler or ctrl[ handler ]
					handler ( ctrl, entry.name, value )
				end
			end
		end
	end
end

local function findbindings ( from, name, input, result, ... )
	if not input then
		for k, v in pairs ( from ) do
			if type ( v ) == "table" and v.name then
				if not name or v.name == name then
					result[ #result + 1 ] = {
						name = v.name,
						input = reverse ( { ... } ),
						options = {
							filter = copy ( v.filter ),
							mapper = copy ( v.mapper ),
							events = copy ( v.events )
						} }
				end
			else
				findbindings ( v, name, nil, result, k, ... )
			end
		end
	else
		for i = 1, #input do
			from = from[ input[ i ] ]
			if not from then return end
		end
		findbindings ( from, name, nil, result, unpack ( reverse ( input ) ) )
	end
end

local function populatevalidinputs ( ctrl )
	-- needs to be consistent with LÃ–VE's features
	local keyboard = lookupify ( {
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
		"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "return", "escape", "backspace", "tab", "space",
		"-", "=", "[", "]", "\\", "nonus#", ";", "'", "`", ",", ".", "/", "capslock",
		"f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12",
		"f13", "f14", "f15", "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23", "f24",
		"ltrl", "lshift", "lalt", "lgui", "rctrl", "rshift", "ralt", "rgui",
		"printscreen", "scrolllock", "pause", "insert", "home", "numlock", "pageup", "delete", "end", "pagedown",
		"right", "left", "down", "up", "nonusbackslash", "application", "execute",
		"help", "menu", "select", "stop", "again", "undo", "cut", "copy", "paste", "find",
		"kp/", "kp*", "kp-", "kp+", "kp=", "kpenter", "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9", "kp0", "kp.",
		"international1", "international2", "international3", "international4", "international5",
		"international6", "international7", "international8", "international9", "lang1", "lang2", "lang3", "lang4", "lang5",
		"mute", "volumeup", "volumedown", "audionext", "audioprev", "audiostop", "audioplay", "audiomute", "mediaselect",
		"www", "mail", "calculator", "computer", "acsearch", "achome", "acback", "acforward", "acstop", "acrefresh", "acbookmarks",
		"power", "brightnessdown", "brightnessup", "displayswitch", "kbdillumtoggle", "kbdillumdown", "kbdillumup",
		"eject", "sleep", "alterase", "sysreq", "cancel", "clear", "prior", "return2", "separator",
		"out", "oper", "clearagain", "crsel", "exsel", "kp00", "kp000",
		"thsousandsseparator", "decimalseparator", "currencyunit", "currencysubunit", "app1", "app2"
	} )
	local mouse = lookupify ( { "x", "y", "wheelx", "wheely", "left", "right", "middle" } )
	local axis = lookupify ( { "leftx", "rightx", "lefty", "righty", "triggerleft", "triggerright" } )
	local button = lookupify ( { "a", "b", "x", "y", "back", "guide", "start", "leftstick", "rightstick", "leftshoulder", "rightshoulder" } )
	local hat = lookupify ( { "up", "down", "left", "right" } )
	local gamepad = {
		axis = axis,
		button = button,
		hat = hat
	}
	local joystick = {
		axis = setmetatable ( { }, { __index = function ( t, k ) if type ( k ) == "number" and k > 0 then return k end end } ),
		button = setmetatable ( { }, { __index = function ( t, k ) if type ( k ) == "number" and k > 0 then return k end end } ),
		hat = setmetatable ( { }, { __index = function ( t, k ) if type ( k ) == "number" and k > 0 then return hat end end } )
	}

	ctrl.validinputs.keyboard = keyboard
	ctrl.validinputs.mouse = setmetatable ( mouse, { __index = function ( t, k ) if type ( k ) == "number" and k > 3 then return k end end } )
	ctrl.validinputs.gamepad = setmetatable ( { }, { __index = function ( t, k ) return gamepad end } )
	ctrl.validinputs.joystick = setmetatable ( { }, { __index = function ( t, k )return joystick end } )
end

local function populatedevmap ( ctrl )
	local joysticks = love.joystick.getJoysticks ( )
	for i, joy in pairs ( joysticks ) do
		if not ctrl.devmap[ joy ] then ctrl.devmap[ joy ] = "default" end
	end
end

local function isvalidinput ( input )
	return type ( input ) == "string" or type ( input ) == "number" or type ( input ) == "boolean"
end

local function hasnotabs ( input )
	return type ( input ) ~= "string" or #input > 0 and string.find ( input, "[\r\n\t]" ) == nil
end

local mousebuttonmap = setmetatable ( {
	"left", "right", "middle",
}, { __index = function ( t, k ) if type ( k ) == "number" and k > 3 then return k end end } )

local hatbuttonmap = {
	dpup = "hat", dpdown = "hat", dpleft = "hat", dpright = "hat",
	a = "button", b = "button", x = "button", y = "button", back = "button", guide = "button", start = "button",
	leftstick = "button", rightstick = "button", leftshoulder = "button", rightshoulder = "button",
	}

local hatdirmap = {
	up = { u = true, lu = true, ru = true },
	down = { d = true, ld = true, rd = true },
	left = { l = true, ld = true, lu = true },
	right = { r = true, rd = true, ru = true },
	up = "u", down = "d", left = "l", right = "r",
	u = "up", d = "down", l = "left", r = "right",

	dpup = "up", dpdown = "down", dpleft = "left", dpright = "right",
	a = "a", b = "b", x = "x", y = "y", back = "back", guide = "guide", start = "start",
	leftstick = "leftstick", rightstick = "rightstick",
	leftshoulder = "leftshoulder", rightshoulder = "rightshoulder",
}

local reservednames = lookupify ( {
	"defaultTriggers", "defaultFilters", "defaultMappers",
	"new", "addInputs", "addTriggerFunction", "addMapperFunction", "addFilterFunction", "mapDevice",
	"handleKeypressed", "handleKeyreleased", "handleMousepressed", "handleMousereleased", "handleMousemoved", "handleWheelmoved",
	"handleGamepadpressed", "handleGamepadreleased", "handleGamepadaxis",
	"handleJoystickpressed", "handleJoystickreleased", "handleJoystickaxis", "handleJoystickhat",
	"handleJoystickadded", "handleUpdate", "handleInput", "hookup",
	"grab", "bind", "unbind", "getMapping", "getBindings", "isUp", "isDown", "getValue", "resetValues",
	"saveData", "loadData", "getGamepadMapping",  "setGamepadMapping" } )

Ctrl.defaultTriggers = {
	pressed = function ( curr, last, args ) return curr > 0.25 and last <= 0.25 end,
	released = function ( curr, last, args ) return curr < 0.75 and last >= 0.75 end,
	moved = function ( curr, last, args ) return curr ~= last end
}

Ctrl.defaultFilters = {
	smooth = function ( dt, raw, last, args ) return last + ( raw - last ) * dt * ( args.speed or 1 ) end,
	ramp = function ( dt, raw, last, args ) return math.max ( math.min ( last + raw * dt * ( args.speed or 1 ), args.max or 1 ), args.min or 0 ) end,
}

Ctrl.defaultMappers = {
	deadzone = function ( raw, last, args ) return math.abs ( raw ) > ( args.deadzone or 0.1 ) and raw or 0 end,
	remap = function ( raw, last, args ) return math.max ( math.min ( ( raw - ( args.rawmin or 0 ) ) / ( ( args.rawmax or 1 ) - ( args.rawmin or 0 ) ) * ( ( args.mapmax or 1 ) - ( args.mapmin or 0 ) ) + ( args.mapmin or 0 ), args.max or 1 ), args.min or 0 ) end
}

Ctrl.handleInput = handle

function Ctrl.new ( )
	local self = setmetatable ( { }, Ctrl )
	self.devmap = { }
	self.values = { }
	self.lastvalues = { }
	self.raws = { }
	self.inputs = { }
	self.validinputs = { }

	self.triggers = setmetatable ( { }, { __index = Ctrl.defaultTriggers } )
	self.mappers = setmetatable ( { }, { __index = Ctrl.defaultMappers } )
	self.filters = setmetatable ( { }, { __index = Ctrl.defaultFilters } )

	populatevalidinputs ( self )
	populatedevmap ( self )

	self._filterlist = { }
	return self
end

function Ctrl.setGamepadMapping ( self, joy, control, input )
	if type ( self ) ~= "table" or ( self ~= Ctrl and getmetatable ( self ) ~= Ctrl ) then
		joy, control, input = self, joy, control
	end
	assert ( type ( joy ) == "userdata" and joy.type and joy:type ( ) == "Joystick", "joystick for mapping must be a joystick" )
	assert ( type ( input ) == "table", "input path must be a table" )
	assert ( input[ 1 ] == "joystick", "only joysticks can be gamepad mapped" )
	assert ( self.validinputs.gamepad._.axis[ control ] or self.validinputs.gamepad._.button[ control ] or self.validinputs.gamepad._.hat[ control ], "invalid gamepad input ID" )
	local guid = joy:getGUID ( )
	local inputtype = input[ 3 ]
	local inputindex = input[ 4 ]
	local hatdirection = inputtype == "hat" and hatdirmap[ input[ 5 ] ] or nil
	return love.joystick.setGamepadMapping ( guid, control, inputtype, inputindex, hatdirection )
end

function Ctrl.getGamepadMapping ( self, joy, control )
	if type ( self ) ~= "table" or ( self ~= Ctrl and getmetatable ( self ) ~= Ctrl ) then
		joy, control = self, joy
	end
	assert ( type ( joy ) == "userdata" and joy.type and joy:type ( ) == "Joystick", "joystick for mapping must be a joystick" )
	local a, b, c = joy:getGamepadMapping ( control )
	return { "joystick", self.devmap[ joy ] or "default", a, b, hatdirmap[ c or 0 ] }
end

function Ctrl:addInputs ( input, new )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( type ( input ) == "table", "input path must be a table" )
	assert ( type ( new ) == "table", "set of new inputs must be a table" )
	local data = self.validinputs
	for i = 1, #input do
		assert ( isvalidinput ( input[ i ] ), "input address must be a string, number or boolean\n\nUse device mapping functionality to map object-based inputs to valid values." )
		assert ( hasnotabs ( input[ i ] ), "input address cannot contain newline or tab characters" )

		if not data[ input[ i ] ] then
			data[ input[ i ] ] = { }
		end
		data = data[ input[ i ] ]
	end
	for k, v in pairs ( new ) do
		assert ( isvalidinput ( v ), "input address must be a string, number or boolean\n\nUse device mapping functionality to map object-based inputs to valid values." )
		assert ( hasnotabs ( v ), "input address cannot contain newline or tab characters" )
		data[ v ] = k
	end
	setmetatable ( data, getmetatable ( new ) )
end

function Ctrl:addTriggerFunction ( name, func )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( hasnotabs ( name ), "trigger function name cannot contain newline or tab characters" )
	assert ( func == nil or type ( func ) == "function", "trigger function must be a function" )
	self.triggers[ name ] = func
end

function Ctrl:addMapperFunction ( name, func )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( hasnotabs ( name ), "mapper function name cannot contain newline or tab characters" )
	assert ( func == nil or type ( func ) == "function", "mapper function must be a function" )
	self.mappers[ name ] = func
end

function Ctrl:addFilterFunction ( name, func )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( hasnotabs ( name ), "filter function name cannot contain newline or tab characters" )
	assert ( func == nil or type ( func ) == "function", "filter function must be a function" )
	self.filters[ name ] = func
end

function Ctrl:handleUpdate ( dt )
	filter ( self, dt )
end

function Ctrl:handleKeypressed ( key, code, repeated )
	handle ( self, { "keyboard", code }, 1 )
end

function Ctrl:handleKeyreleased ( key, code, repeated )
	handle ( self, { "keyboard", code }, 0 )
end

function Ctrl:handleMousepressed ( x, y, button, touch )
	handle ( self, { "mouse", "x" }, x, 0, touch )
	handle ( self, { "mouse", "y" }, y, 0, touch )
	handle ( self, { "mouse", mousebuttonmap[ button ] }, 1, touch )
end

function Ctrl:handleMousereleased ( x, y, button, touch )
	handle ( self, { "mouse", "x" }, x, 0, touch )
	handle ( self, { "mouse", "y" }, y, 0, touch )
	handle ( self, { "mouse", mousebuttonmap[ button ] }, 0, touch )
end

function Ctrl:handleMousemoved ( x, y, dx, dy, touch )
	handle ( self, { "mouse", "x" }, x, dx, touch )
	handle ( self, { "mouse", "y" }, y, dy, touch )
end

function Ctrl:handleWheelmoved ( x, y )
	if x ~= 0 then handle ( self, { "mouse", "wheelx" }, x ) end
	if y ~= 0 then handle ( self, { "mouse", "wheely" }, y ) end
end

function Ctrl:handleGamepadaxis ( joy, axis, value )
	handle ( self, { "gamepad", self.devmap[ joy ], "axis", axis }, value )
end

function Ctrl:handleGamepadpressed ( joy, button )
	handle ( self, { "gamepad", self.devmap[ joy ], hatbuttonmap[ button ], hatdirmap[ button ] }, 1 )
end

function Ctrl:handleGamepadreleased ( joy, button )
	handle ( self, { "gamepad", self.devmap[ joy ], hatbuttonmap[ button ], hatdirmap[ button ] }, 0 )
end

function Ctrl:handleJoystickaxis ( joy, axis, value )
	handle ( self, { "joystick", self.devmap[ joy ], "axis", axis }, value )
end

function Ctrl:handleJoystickhat ( joy, hat, dir )
	joy = self.devmap[ joy ]

	local up = hatdirmap.up[ dir ]
	local down = hatdirmap.down[ dir ]
	local left = hatdirmap.left[ dir ]
	local right = hatdirmap.right[ dir ]

	if not up    then handle ( self, { "joystick", joy, "hat", hat, "up" },    0 ) end
	if not down  then handle ( self, { "joystick", joy, "hat", hat, "down" },  0 ) end
	if not left  then handle ( self, { "joystick", joy, "hat", hat, "left" },  0 ) end
	if not right then handle ( self, { "joystick", joy, "hat", hat, "right" }, 0 ) end

	if up    then handle ( self, { "joystick", joy, "hat", hat, "up" },    1 ) end
	if down  then handle ( self, { "joystick", joy, "hat", hat, "down" },  1 ) end
	if left  then handle ( self, { "joystick", joy, "hat", hat, "left" },  1 ) end
	if right then handle ( self, { "joystick", joy, "hat", hat, "right" }, 1 ) end
end

function Ctrl:handleJoystickpressed ( joy, button )
	handle ( self, { "joystick", self.devmap[ joy ], "button", button }, 1 )
end

function Ctrl:handleJoystickreleased ( joy, button )
	handle ( self, { "joystick", self.devmap[ joy ], "button", button }, 0 )
end

function Ctrl:handleJoystickadded ( joy )
	if not self.devmap[ joy ] then
		self.devmap[ joy ] = "default"
	end
end

function Ctrl:handleJoystickremoved ( joy )
	self.devmap[ joy ] = nil
end

function Ctrl:grab ( callback, autobind, filter )
	if not callback and not autobind and not filter then
		self.tograb = nil
		prune ( self, "inputs" )
		self.inputs = self.inputs or { }
		self.raws = { }
		return
	end

	if type ( callback ) == "table" then callback, autobind, filter = nil, callback, autobind end
	if type ( callback ) == "string" then callback, autobind, filter = nil, callback, autobind end
	if type ( autobind ) == "table" then autobind, filter = nil, autobind end

	assert ( callback or autobind, "can't start input aquisition without handling routine" )

	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( callback == nil or type ( callback ) == "function", "input grab callback must be a function" )
	assert ( autobind == nil or ( type ( autobind ) == "string" and hasnotabs ( autobind ) ), "input name cannot contain newline or tab characters" )
	assert ( filter == nil or type ( filter ) == "table", "input filter must be a table" )

	if filter then filter = type ( filter[ 1 ] ) == "table" and filter or { filter } end
	self.tograb = { callback = callback, autobind = autobind, filter = filter }
end

function Ctrl:mapDevice ( device, value )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( device, "cannot map nil device" )
	assert ( isvalidinput ( value ), "device can only be mapped to a string, number or boolean" )
	assert ( hasnotabs ( value ), "input address cannot contain newline or tab characters" )
	self.devmap[ device ] = value
end

function Ctrl:getMapping ( device )
	return self.devmap[ device ] or "default"
end

function Ctrl:bind ( name, input, options, validate )
	if validate == nil then validate = true end
	-- validate input request
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( type ( name ) == "string", "input name must be a string" )
	assert ( hasnotabs ( name ), "input name cannot contain newline or tab characters" )
	if validate then
		local data = self.validinputs
		for i = 1, #input do
			assert ( isvalidinput ( input[ i ] ), "input address must be a string, number or boolean\n\nUse device mapping functionality to map object-based inputs to valid values." )
			assert ( hasnotabs ( input[ i ] ), "input address cannot contain newline or tab characters" )
			if not data[ input[ i ] ] then
				local str = "invalid input type: '" .. input[ 1 ] .. "'"
				for i = 2, #input do
					str = str .. "->'" .. input[ i ]
				end
				assert ( false, str )
			end
			data = data[ input[ i ] ]
		end
		assert ( type ( data ) ~= "table", "input address must be complete" )
	end
	if options and options ~= "none" then
		if options.mapper then
			assert ( type ( options.mapper.func ) == "function" or self.mappers[ options.mapper.func ], "mapper function must be a function" )
		end
		if options.filter then
			assert ( type ( options.filter.func ) == "function" or self.filters[ options.filter.func ], "filter function must be a function" )
		end
		if options.events and options.events ~= "default" then
			assert ( type ( options.events ) == "table", "event list must be a table" )
			for k, event in pairs ( options.events ) do
				assert ( type ( event.trigger ) == "function" or self.triggers[ event.trigger ], "event trigger must be a function" )
				assert ( type ( event.handler ) == "function" or type ( event.handler ) == "string", "event handler must be a function or handler callback name" )
				assert ( type ( event.handler ) ~= "string" or not reservednames[ event.handler ], "cannot use reserved name for event handler" )
			end
		end
	end

	-- select input slot data, create necessary input tree
	data = self.inputs
	for i = 1, #input do
		if not data[ input[ i ] ] then
			data[ input[ i ] ] = { }
		end
		data = data[ input[ i ] ]
	end

	-- try to find existing entry and erase it
	local erased = false
	for i = 1, #data do
		if data[ i ].name == name then
			data[ i ].name, data[ i ].options = nil, nil
			data = data[ i ]
			erased = true
		end
	end

	-- create new entry if none exists
	if not self.values[ name ] then
		self.values[ name ], self.lastvalues[ name ] = 0, 0
	end
	if not erased then
		data[ #data + 1 ] = { }
		data = data[ #data ]
	end

	-- fill in entry data
	data.name = name
	if options ~= "none" then
		data.filter = options and copy ( options.filter )
		data.mapper = options and copy ( options.mapper )
		if options and options.events and options.events ~= "none" then
			data.events = copy ( options.events )
		elseif options and not options.events or not options then
			-- default events: for digital keys - "pressed" or "released", for axis - "moved"
			local digital = true
			if ( input[ 1 ] == "gamepad" or input[ 1 ] == "joystick" ) and input[ 3 ] == "axis" then
				digital = false
			elseif input[ 1 ] == "mouse" and ( input[ 2 ] == "x" or input[ 2 ] == "y" ) then
				digital = false
			end

			if digital then
				data.events = {
					pressed = { trigger = "pressed", handler = "inputpressed" },
					released = { trigger = "released", handler = "inputreleased" }
				}
			else
				data.events = { moved = { trigger = "moved", handler = "inputmoved" } }
			end
		end
	end
	if data.filter then
		self._filterlist[ #self._filterlist + 1 ] = data
	end
end

function Ctrl:unbind ( name, input )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	if name and not input and type ( name ) == "table" then
		input = name
		name = nil
	end

	-- unbind all shortcut
	if not name and not input then
		self.values, self.lastvalues = { }, { }
		self.inputs = { }
		self._filterlist = { }
		return
	end

	-- find relevant entries list
	local data = self.inputs
	if input then
		for i = 1, #input do
			data = data[ input[ 1 ] ]
			if not data then return end
		end
	end

	unbind ( self, data, name )
	prune ( self, "inputs" )
	self.inputs = self.inputs or { }
	self.raws = { }
	if name then
		self.values[ name ] = nil
	else
		for k, v in pairs ( self.values ) do
			if not self:getBindings ( k ) then
				self.values[ k ], self.lastvalues[ k ] = nil, nil
			end
		end
	end
end

function Ctrl:getBindings ( name, input )
	if type ( name ) == "table" and not input then
		input, name = name, nil
	end
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	assert ( name == nil or type ( name ) == "string", "input name must be a string" )
	assert ( input == nil or type ( input ) == "table", "input address must be a table" )
	if type ( input ) == "table" then
		local data = self.validinputs
		for i = 1, #input do
			assert ( isvalidinput ( input[ i ] ), "input address must be a string, number or boolean\n\nUse device mapping functionality to map object-based inputs to valid values." )
			assert ( hasnotabs ( input[ i ] ), "input address cannot contain newline or tab characters" )
			if not data[ input[ i ] ] then
				local str = "invalid input type: '" .. input[ 1 ] .. "'"
				for i = 2, #input do
					str = str .. "->'" .. input[ i ]
				end
				assert ( false, str )
			end
			data = data[ input[ i ] ]
		end
	end
	local binds = { }
	findbindings ( self.inputs, name, input, binds )
	return binds
end

function Ctrl:isDown ( name )
	return self.values[ name ] and self.values[ name ] > 0.75 or false
end

function Ctrl:isUp ( name )
	return self.values[ name ] and self.values[ name ] < 0.25 or false
end

function Ctrl:getValue ( name )
	return self.values[ name ] and self.values[ name ] or 0
end

function Ctrl:wasDown ( name )
	return self.lastvalues[ name ] and self.lastvalues[ name ] > 0.75 or false
end

function Ctrl:wasUp ( name )
	return self.lastvalues[ name ] and self.lastvalues[ name ] < 0.25 or false
end

function Ctrl:getLastValue ( name )
	return self.lastvalues[ name ] and self.lastvalues[ name ] or 0
end

function Ctrl:resetValues ( )
	for k, v in pairs ( self.values ) do
		self.values[ k ], self.lastvalues[ k ] = 0, 0
	end
	self.raws = { }
end

function Ctrl:saveData ( filename )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	local allbindings = { }
	for name, _ in pairs ( self.values ) do
		allbindings[ name ] = self:getBindings ( name )
	end
	local output = { }

	for name, bindings in pairs ( allbindings ) do
		for i, binding in pairs ( bindings ) do
			output[ #output + 1 ] = "input\t"
			output[ #output + 1 ] = name
			output[ #output + 1 ] = "\nbinding"
			for _, input in ipairs ( binding.input ) do
				output[ #output + 1 ] = "\t"
				output[ #output + 1 ] = input
			end
			output[ #output + 1 ] = "\n"
			binding = binding.binding
			if binding.mapper then
				output[ #output + 1 ] = "option\tmapper"
				if type ( binding.mapper.func ) == "string" then
					output[ #output + 1 ] = "\t"
					output[ #output + 1 ] = binding.mapper.func
				end
				output[ #output + 1 ] = "\n"
				for k, v in pairs ( binding.mapper.args or { } ) do
					if isvalidinput ( k ) and isvalidinput ( v ) and hasnotabs ( k ) and hasnotabs ( v ) then
						output[ #output + 1 ] = "\t"
						output[ #output + 1 ] = k
						output[ #output + 1 ] = "\t"
						output[ #output + 1 ] = v
						output[ #output + 1 ] = "\n"
					end
				end
			end
			if binding.filter then
				output[ #output + 1 ] = "option\tfilter"
				if type ( binding.filter.func ) == "string" then
					output[ #output + 1 ] = "\t"
					output[ #output + 1 ] = binding.filter.func
				end
				output[ #output + 1 ] = "\n"
				for k, v in pairs ( binding.filter.args or { } ) do
					if isvalidinput ( k ) and isvalidinput ( v ) and hasnotabs ( k ) and hasnotabs ( v ) then
						output[ #output + 1 ] = "\t"
						output[ #output + 1 ] = k
						output[ #output + 1 ] = "\t"
						output[ #output + 1 ] = v
						output[ #output + 1 ] = "\n"
					end
				end
			end
			if binding.events then
				for e, evt in pairs ( binding.events ) do
					if isvalidinput ( e ) and hasnotabs ( e ) then
						output[ #output + 1 ] = "option\tevent\t"
						output[ #output + 1 ] = e
						output[ #output + 1 ] = "\t"
						output[ #output + 1 ] = evt.handler
						if type ( evt.trigger ) == "string" then
							output[ #output + 1 ] = "\t"
							output[ #output + 1 ] = evt.trigger
						end
						output[ #output + 1 ] = "\n"
						if evt.args then
							for k, v in pairs ( evt.args ) do
								if isvalidinput ( k ) and isvalidinput ( v ) and hasnotabs ( k ) and hasnotabs ( v ) then
									output[ #output + 1 ] = "\t"
									output[ #output + 1 ] = k
									output[ #output + 1 ] = "\t"
									output[ #output + 1 ] = v
									output[ #output + 1 ] = "\n"
								end
							end
						end
					end
				end
			end

			output[ #output + 1 ] = "\n"
		end
	end

	local mappings = love.joystick.saveGamepadMappings ( )
	if mappings then
		output[ #output + 1 ] = "mappings\n"
		output[ #output + 1 ] = mappings
	end

	output = table.concat ( output )

	if filename then
		love.filesystem.write ( filename, output )
	else
		return output
	end
end

function Ctrl:loadData ( data )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	if love.filesystem.isFile ( data ) then
		data = love.filesystem.read ( data )
	end
	local newdata = { }
	local newline, newtab
	for line in string.gmatch ( data, "[^\n\r]+" ) do
		if newline then newline, newdata[ #newdata ] = nil, nil end
		local d = { }
		if string.sub ( line, 1, 1 ) == "\t" then
			d[ #d + 1 ] = "data"
		end
		for tabs in string.gmatch ( line, "[^\t%s]+" ) do
			d[ #d + 1 ] = tabs
		end
		newdata[ #newdata + 1 ] = d
	end

	local state, state2, state3
	local inputname, inputpath, inputmapper, inputfilter, inputevents
	local inputs = { }
	for _, data in ipairs ( newdata ) do
		if state ~= "mappings" then state = data[ 1 ] end
		if state == "input" then
			if inputname then
				inputs[ #inputs + 1 ] = { name = inputname, input = inputpath, mapper = inputmapper, filter = inputfilter, events = inputevents }
				inputpath, inputmapper, inputfilter, inputevents = nil, nil, nil, nil
			end
			inputname = data[ 2 ]
		elseif state == "binding" then
			if not inputname then return nil, "data corrupt" end
			inputpath = { }
			for i = 2, #data do
				inputpath[ #inputpath + 1 ] = data[ i ]
			end
		elseif state == "option" then
			if not inputname then return nil, "data corrupt" end
			state2 = data[ 2 ]
			if state2 == "mapper" then
				inputmapper = inputmapper or { }
				inputmapper.func = data[ 3 ]
			elseif state2 == "filter" then
				inputfilter = inputfilter or { }
				inputfilter.func = data[ 3 ]
			elseif state2 == "event" then
				state3 = data[ 3 ]
				inputevents = inputevents or { }
				inputevents[ state3 ] = inputevents[ state3 ] or { }
				inputevents[ state3 ].handler = data[ 4 ]
				inputevents[ state3 ].trigger = data[ 5 ]
			end
		elseif state == "data" then
			if not inputname then return nil, "data corrupt" end
			local target
			if state2 == "mapper" then target = inputmapper
			elseif state2 == "filter" then target = inputfilter
			elseif state2 == "event" then target = inputevents[ state3 ] end
			target.args = target.args or { }
			target.args[ data[ 2 ] ] = data[ 3 ]
		elseif state == "mappings" then
			if inputname then
				inputs[ #inputs + 1 ] = { name = inputname, input = inputpath, mapper = inputmapper, filter = inputfilter, events = inputevents }
				inputname = nil
			else
				love.joystick.loadGamepadMappings ( table.concat ( data, " " ) )
			end
		end
	end
	local function dummymapper ( raw ) return raw end
	local function dummyfilter ( dt, raw ) return raw end
	local function dummytrigger ( ) return false end
	for _, input in ipairs ( inputs ) do
		if input.mapper and not input.mapper.func then input.mapper.func = dummymapper end
		if input.filter and not input.filter.func then input.filter.func = dummyfilter end
		if input.events then
			for _, evt in pairs ( input.events ) do
				if not evt.trigger then evt.trigger = dummytrigger end
			end
		end
		self:bind ( input.name, input.input, { mapper = input.mapper, filter = input.filter, events = input.events } )
	end
end

function Ctrl:hookup ( )
	assert ( self ~= Ctrl, "cannot call function on class\n\nCreate class instance and call this function on it instead." )
	local functions = {
		--handleUpdate           = "update",
		handleKeypressed       = "keypressed",
		handleKeyreleased      = "keyreleased",
		handleMousemoved       = "mousemoved",
		handleMousepressed     = "mousepressed",
		handleMousereleased    = "mousereleased",
		handleWheelmoved       = "wheelmoved",
		--"touchmoved",
		--"touchpressed",
		--"touchreleased",
		handleGamepadaxis      = "gamepadaxis",
		handleGamepadpressed   = "gamepadpressed",
		handleGamepadreleased  = "gamepadreleased",
		handleJoystickaxis     = "joystickaxis",
		handleJoystickhat      = "joystickhat",
		handleJoystickpressed  = "joystickpressed",
		handleJoystickreleased = "joystickreleased",
		handleJoystickadded    = "joystickadded",
	}

	for handler, func in pairs ( functions ) do
		local lovefunc = love[ func ]
		love[ func ] = function ( ... )
			self[ handler ] ( self, ... )
			if lovefunc then lovefunc ( ... ) end
		end
	end
	local loveupdate = love.update
	love.update = function ( dt )
		self:handleUpdate ( dt )
		loveupdate ( dt )
		for k, v in pairs ( self.values ) do
			self.lastvalues[ k ] = v
		end
	end
end

return Ctrl