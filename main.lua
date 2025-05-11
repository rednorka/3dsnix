-- 3DSnix
-- Control Nintendo Switch from Nintendo 3DS via sys-botbase
-- Rednorka
-- v0.0.1

-- TO-DO:
-- - Sticks and ZR/ZL support
-- - Pretty UI
-- - Quick reconnect
-- - Error handling

local socket = require("socket")

local ip = ""
local nx = nil
local ds = love.joystick.getJoysticks()[1]

local poll = {}

local info = "Hello!"
local lastpress = ""

function switchConnect()
	love.keyboard.setTextInput(true, {hint = "Enter Switch's IP", length = 15})
end

function getLeftStick()
	local leftx = string.format("%x", math.abs(math.floor(ds:getGamepadAxis("leftx")*32768)))
	local lefty = string.format("%x", math.abs(math.floor(ds:getGamepadAxis("lefty")*32768)))
	
	if ds:getGamepadAxis("leftx") < 0 then leftx = "-"..leftx end
	if ds:getGamepadAxis("lefty") < 0 then lefty = "-"..lefty end
	
	return "LEFT "..leftx.." "..lefty
end

function buttonRemap(btn)
	local map = {
		a = "A",
		b = "B",
		x = "X",
		y = "Y",
		leftshoulder = "L",
		rightshoulder = "R",
		dpup = "DU",
		dpdown = "DD",
		dpleft = "DL",
		dpright = "DR",
		start = "PLUS",
		back = "MINUS"
	}
	if map[btn] then
		return map[btn]
	else
		return "HOME"
	end
end



function love.gamepadpressed(joystick, button)
	button = buttonRemap(button)
	
	table.insert(poll, "+"..button)
	lastpress = button
end

function love.gamepadreleased(joystick, button)
	button = buttonRemap(button)
	
	table.insert(poll, "-"..button)
	lastpress = button
end

function love.textinput(text)
	ip = text
	nx = socket.connect(ip, 6000)
	nx:settimeout(0)
	
	nx:send("configure mainLoopSleepTime 1\r\n")
end

function love.touchpressed()
	love.event.quit()
end

function love.quit()
	if nx then nx:send("detachController\r\n") end
end



function love.load()
	switchConnect()
end

function love.update()
	if nx == nil then
		info = "No connection :("
	else
		info = getLeftStick()
		
		if #poll > 0 then
			nx:send("clickSeq "..table.concat(poll, ",W1,").."\r\n")
			poll = {}
		end
	end
end

function love.draw(screen)
	if screen ~= "bottom" then
		love.graphics.print(info)
	else
		love.graphics.print(lastpress)
	end
end