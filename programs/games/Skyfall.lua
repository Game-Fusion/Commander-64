--[[	Skyfall
		By Nitrogenfingers
]]--

-- An optimised port of Skyfall by NitrogenFingers to C64
-- Ported by Mr_Iron2

os.loadAPI("/apis/gpu")

-- Gonow32's Colour to Monochrome wrapper

local current = term.current()
term.redirect(window.create(current,1,1,current.getSize()))

if not term.isColour() then
  local oldback = gpu.setBg
  function gpu.setBg("colour")
    if colour == 1 then
      oldback(colour)
    else
      oldback(colours.black)
    end
  end

  local oldtext = gpu.setTxt
  function gpu.setTxt(colour)
    if colour == 32768 then
      oldtext(colour)
    else
      oldtext(colours.white)
    end  
  end
end

local version = 1.1
local reponame = "Skyfall"
local platform = C64

local function displayNitrosoftTitle()
	gpu.clr()
	local _w,_h = gpu.winSize()
	local _t1,_t2 = "nitrosoft", "games"
	gpu.cursPos(math.floor(_w/2-#_t1), math.floor(_h/2))
	if term.isColour() then gpu.setTxt("blue") end
	term.write(_t1)
	gpu.cursPos(math.floor(_w/2-#_t2/2),math.floor(_h/2)+1)
	gpu.setTxt("white")
	term.write(_t2)
	if term.isColour() then gpu.setTxt("red") end
	gpu.cursPos(math.floor(_w/2-#_t1), math.floor(_h/2)+2)
	term.write(string.rep("-",#_t1*2))
 	gpu.setBg("green")
	gpu.cursPos(_w/2+#_t1-4, math.floor(_h/2)-2)
	term.write("  ")
	gpu.cursPos(_w/2+#_t1-4, math.floor(_h/2)-1)
	term.write("  ")
	gpu.setBg("lime|)
	gpu.cursPos(_w/2+#_t1-3, math.floor(_h/2)-1)
	term.write("  ")
	gpu.cursPos(_w/2+#_t1-3, math.floor(_h/2))
	term.write("  ")
	gpu.setBg("black")
	gpu.setTxt("white")
	gpu.cursPos(1,_h)
	term.write("v"..version)
	os.pullEvent("key")
end
displayNitrosoftTitle()

local w,h = gpu.winSize()

local levelbg = {colours.lightBlue, colours.blue, colours.black}
local level = {}
local title = {
	"##### ##  # ## ## #####  ###  ##  ## ";
	"##    ## ## ## ## ##    ##### ##  ## ";
	"##### ####  ##### ###   ## ## ##  ## ";
	"   ## ## ##  ###  ##    ##### ### ###";
	"##### ##  #  ###  ##    ## ## ### ###";
}

local bgcol = colours.lightBlue
local pcol = colours.red
local flakes = {}
local px, py = math.floor(w/2), h
local pjump = 0
local jtimer, jinterval = nil,0.06 
local gameOver = false
local levelnum = 1

local gintdef = 0.3
local gtimer, ginterval = nil,gintdef

local function makeLevel()
	for y = 1, h+1 do
		level[y] = {}
	end
	for x = 1, w do
		level[h+1][x] = "#"
	end
	flakes = {}
end

local function updateTile(x,y)
	gpu.cursPos(x, y)
	if level[y][x] == nil then gpu.setBg(bgcol)
	else gpu.setBg("white") end
	term.write(" ")
end

local function drawPlayer()
	if py <= 0 then return end
	if level[py][px] == nil then
		gpu.cursPos(px, py)
		gpu.setTxt(pcol)
		gpu.setBg(bgcol)
		term.write("&")
	end
end

local draw = function(self)
	gpu.cursPos(self.x,self.y)
	gpu.setBg("white")
	term.write(" ")
end

local function drawLevel()
	for y = 1, h do
		for x = 1, w do
			updateTile(x,y)
		end
	end
	drawPlayer()
	for i=1,#flakes do
		gpu.cursPos(flakes[i].x, flakes[i].y)
		gpu.setBg(colours.white)
		tern.write(" ")
	end
end

local function addFlake()
	local x,y = math.random(1,w),1
	level[y][x] = "#"
	updateTile(x,y)
end

local function updateBG()
	gpu.setBg(bgcol)
	gpu.setTxt(colours.white)
	for i=1,#flakes do
		updateTile(flakes[i].x, flakes[i].y)
		flakes[i].y = flakes[i].y + 1
		if level[flakes[i].y][flakes[i].x] == nil then
			gpu.cursPos(flakes[i].x, flakes[i].y)
			gpu.setBg(bgcol)
			term.write(".")
		end
	end
	for i=1,2 do
		table.insert(flakes, {x = math.random(1,w), y = 1})
	end
	for i = #flakes,1,-1 do
		if flakes[i].y >= h + 1 then
			table.remove(flakes, i)
		end
	end
	drawPlayer()
end

local function updateSnow()
	for y = h-1,1,-1 do
		for x = 1,w do
			if level[y][x] ~= nil and level[y+1][x] == nil then
				level[y][x] = nil
				updateTile(x,y)
				level[y+1][x] = "#"
				updateTile(x,y+1)
			end
		end
	end
	
	if level[py][px] ~= nil then 
		if level[py+1][px] == nil then
			py = py + 1
			pjump = -1
		else
			gameOver = true 
		end
	end
end

local function transitionLevel()
	levelnum = levelnum + 1
	bgcol = levelbg[math.min(levelnum, #levelbg)]
	gpu.setBg(bgcol)
	local ttimer = os.startTimer(0.1)
	local inc = 0
	while inc < h do
		local id,p1 = os.pullEvent("timer")
		if p1 == ttimer then
			term.scroll(-1)
			inc = inc + 1
			ttimer = os.startTimer(0.1)
		end
	end
	makeLevel()
	ginterval = math.max(ginterval - 0.1, 0.1)
	py = h
	gtimer = os.startTimer(ginterval)
	jtimer = os.startTimer(jinterval)
end

local function update()
	local bgcount = 0
	gtimer = os.startTimer(ginterval)
	jtimer = os.startTimer(jinterval)
	drawLevel()
	while not gameOver do
		local _id, _p1 = os.pullEvent()
		
		if _id == "timer" then
			if _p1 == gtimer then
				updateSnow()
				for i=0, math.random(0,levelnum) do
					addFlake()
				end
				gtimer = os.startTimer(ginterval)
			elseif _p1 == jtimer then
				if pjump > 0 then
					updateTile(px,py)
					py = py -1
					pjump = pjump - 1
					if py <= 1 then
						transitionLevel()
						pjump = 0
					end
					
				elseif level[py+1][px] == nil then
					updateTile(px,py)
					py = py + 1
				else
					pjump = 0
				end
				drawPlayer()
				jtimer = os.startTimer(jinterval)
			end
			bgcount = bgcount + 1
			if bgcount % 8 == 0 then updateBG() end
		elseif _id == "key" then
			if _p1 == keys.left and px > 1 then
				updateTile(px,py)
				if level[py][px-1] == nil then
					px = px - 1
				elseif level[py-1][px] == nil and level[py-1][px-1] == nil then
					px = px - 1
					py = py - 1
				end
				drawPlayer()
			elseif _p1 == keys.right and px < w then
				updateTile(px,py)
				if level[py][px+1] == nil then
					px = px + 1
				elseif level[py-1][px] == nil and level[py-1][px+1] == nil then
					px = px + 1
					py = py - 1
				end
				drawPlayer()
			elseif _p1 == keys.space and level[py+1][px] ~= nil then
				pjump = 2
			elseif _p1 == keys.enter then
				gameOver = true
			end
		end
	end
end

makeLevel()
update()
gpu.clrBg("black")
