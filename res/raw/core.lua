-- called after setting up the java part of the love api

function love.draw() end
function love.focus() end
function love.joystickpressed() end
function love.joystickreleased() end
function love.keypressed() end
function love.keyreleased() end
function love.load() end
function love.mousepressed() end
function love.mousereleased() end
function love.quit() end
function love.run() end
function love.update() end

function require(file)
	if (string.sub(file,-4) ~= ".lua") then file = file .. ".lua" end
	print("love-android require:".."'"..tostring(file).."'")
	return love.filesystem.load(file)()
end

function love_andorid_list_iter (t)
	local i = 0
	local n = table.getn(t)
	return function ()
		i = i + 1
		if i <= n then return t[i] end
	end
end

-- default love.conf
local default_screen_w = 800 -- todo: nil for native ? might be trouble 
local default_screen_h = 600
function love.conf(t)
    t.title = "Untitled"        -- The title of the window the game is in (string)
    t.author = "Unnamed"        -- The author of the game (string)
    t.identity = nil            -- The name of the save directory (string)
    t.version = 0               -- The L�VE version this game was made for (number)
    t.console = false           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    t.screen.width = default_screen_w -- 800        -- The window width (number)
    t.screen.height = default_screen_h -- 600       -- The window height (number)
    t.screen.fullscreen = false -- Enable fullscreen (boolean)
    t.screen.vsync = true       -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    t.modules.joystick = true   -- Enable the joystick module (boolean)
    t.modules.audio = true      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = true      -- Enable the sound module (boolean)
    t.modules.physics = true    -- Enable the physics module (boolean)
end

function love_andorid_exec_conf ()
	local t = { screen={}, modules={} }
	love.conf(t)
	if (not t.android_native_screen) then
		local w = t.screen and t.screen.width or default_screen_w
		local h = t.screen and t.screen.height or default_screen_h
		print("love-android: conf.lua : love.graphics.setMode "..tostring(w)..","..tostring(h)) 
		love.graphics.setMode(w,h)
	else
		print("love-android: conf.lua android_native_screen=true, skipping love.graphics.setMode") 
	end
end

-- load and run conf.lua if available, or use default options if not
local mycode = love.filesystem.load("conf.lua")
if (mycode) then 
	print("love-android: conf.lua loaded, executing...") 
	mycode()
else
	print("love-android: loading conf.lua failed, falling back to default") 
end
love_andorid_exec_conf()

	
