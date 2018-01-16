--	LaserBlast by NitrogenFingers
--	Port and optimisation by Mr_Iron2
--	Note: Requires latest APIs

os.loadAPI("/apis/gpu.lua")
os.loadAPI("/apis/cpu.lua")
os.loadAPI("/apis/iop.lua")

local w,h = gpu.winSize()
local plpos = math.floor(w/2)

--music stuff
local minterval = 1
local mtimer = 1
local left = false

local level = 1
local score = 0
local gameover = false
local killc = 0

--x,y,dir
local projlist = {}
--x,y,intvspeed,dtimer
local baddylist = {}
local btimer = 0
local bintv = 1
local utime = 0.05
local bsmp = 6
local powerup = 0

--Landscape and stars
local stars = {}
for i=1,math.random()*10+10 do
  stars[i] = { x = math.ceil(math.random()*w),
    y = math.ceil(math.random() * h-8) }
end
local landscape = {
  [6]="                  ___________________              ";
  [5]="          _______/                   \\_____        ";
  [4]="    ____//       \\________                \\_________";
  [3]="   /    /                 \\                      ";
  [2]="  /    /                   \\_________               ";
  [1]="_/____/                              \\______________";
}

function drawHeader()
  if term.isColour() then gpu.setTxt("white") end
  gpu.cursPos(5, 1)
  gpu.write("Score: "..score)
  if score~=0 then gpu.write("00") end
  local lstr = "Level: "..level
  gpu.cursPos(w-#lstr-5,1)
  gpu.write(lstr)
  
  if powerup > 0 then
    local pstr = "POWERUP"
    gpu.cursPos(w/2 - #pstr/2,1)
	if term.isColour() then gpu.setTxt("cyan") end
	gpu.write(pstr)
  end
end

function drawPlayer()
  if term.isColour() then gpu.setTxt("white") end
  gpu.cursPos(plpos-1, h-1)
  gpu.write("@@@")
end

function drawProjectile(proj)
  if term.isColour() then gpu.setTxt("red") end
  gpu.cursPos(proj.x, proj.y)
  gpu.write("|")
end

function drawVacance(x,y)
  gpu.cursPos(x, y)
  for _,baddy in pairs(baddylist) do
    if baddy.x == x and baddy.y == y and baddy.dtimer > 0 then
      drawBaddie(baddy)
   	  return
	end
  end
  
  if y >= h-8 and y <= h-3 then
    if term.isColour() then gpu.setTxt("lime") end
    gpu.write(string.sub(landscape[h - y - 2], x, x))
  elseif y < h-8 then
	for i=1,#stars do
	  if x == stars[i].x and y == stars[i].y then 
	    if term.isColour() then gpu.setTxt("yellow") end
	    gpu.write(".")
		return
      end
	end
	gpu.write(" ")
  else
	gpu.write(" ")
  end
end

function drawBaddie(baddy)
  gpu.cursPos(baddy.x, baddy.y)
    if baddy.dtimer==0 then
      if baddy.pup then 
        if term.isColour() then gpu.setTxt("blue") end
        gpu.write("P")
      elseif baddy.frag then
        if term.isColour() then gpu.setTxt("brown") end
        gpu.write("*")
      else 
        if term.isColour() then gpu.setTxt("brown") end
        gpu.write("O") 
      end
    else
      if term.isColour() then gpu.setTxt("orange") end
      gpu.write("#")
    end
end

function drawWorld()
  drawLandscape()
  drawPlayer()
  drawHeader()
end

function drawLandscape()
  if term.isColour() then
    gpu.setTxt("yellow")
  end
  for i=1,#stars do
    gpu.cursPos(stars[i].x, stars[i].y)
    gpu.write(".")
  end
  
  gpu.cursPos(1,h)
  local land = string.rep("-", w)
  if term.isColour() then
    gpu.setTxt("green")
  end
  gpu.write(land)
  if term.isColour() then
    gpu.setTxt("lime")
  end
  
  for y,line in ipairs(landscape) do
	gpu.cursPos(1,h-y-2)
	gpu.write(line)
  end
end

function updateWorld()
  --Music  
  iop.rSetOutput("back", false)
  mtimer=mtimer-utime
  if mtimer<=0 then
    mtimer = minterval
    if left then
      iop.rSetOutput("left", true)
      iop.rSetOutput("right", false)
    else
      iop.rSetOutput("left", false)
      iop.rSetOutput("right", true)
    end
    left = not left
  end

  local i=1
  while i<=#projlist do
	drawVacance(projlist[i].x, projlist[i].y)
    projlist[i].y = projlist[i].y+projlist[i].dir
	if projlist[i].y <= 1 or projlist[i].y > h-1 then
      table.remove(projlist,i)
      i=i-1
    else drawProjectile(projlist[i]) end
    i=i+1
  end
  i=1
  while i<=#baddylist do
    local baddy = baddylist[i]
    baddy.timer=baddy.timer+utime

    if baddy.y==h-1 and math.abs(baddy.x-plpos)<2 then
      if baddy.pup then
    	powerup = 10
		drawPlayer()
      else
        gameover = true 
        iop.rSetOutput("back", true)
      end
    end

    j=1
    while j<=#projlist do
      local proj = projlist[j]
      if baddy.x==proj.x and math.abs(baddy.y-proj.y)<2
      and baddy.dtimer==0 then
        baddy.dtimer = 0.5
		drawBaddie(baddy)
		drawVacance(projlist[j].x, projlist[j].y)
        table.remove(projlist,j)
        j=j-1
        score=score+5
        iop.rSetOutput("back", true)
        killc=killc+1
        if killc>5+(level*5) and level<10 then levelUp() end
		drawHeader()

        --Adds fragments
        if math.random(1, 5) == 2 and not baddy.frag then
          table.insert(baddylist, {
            x = baddy.x-1,
            y = baddy.y,
            pup = false,
            frag = true,
            timer = 0,
            dtimer = 0,
            speed = baddy.speed/2
          })
		  drawBaddie(baddylist[#baddylist])
          table.insert(baddylist, {
            x = baddy.x+1,
            y = baddy.y,
            pup = false,
            frag = true,
            timer = 0,
            dtimer = 0,
            speed = baddy.speed/2
          })
		  drawBaddie(baddylist[#baddylist])
        end
      end
      j=j+1
    end

    if baddy.timer>baddy.speed and baddy.dtimer==0 then
	  drawVacance(baddy.x, baddy.y)
      baddy.y=baddy.y+1
      if baddy.y==h then
        table.remove(baddylist,i)
        i=i-1
        score=score-1
		drawHeader()
      else
	    drawBaddie(baddy)
        baddy.timer = 0
	  end
    elseif baddy.dtimer>0 then
      baddy.dtimer=baddy.dtimer-utime
      if baddy.dtimer<=0 then
        drawVacance(baddy.x, baddy.y)
		table.remove(baddylist,i)
        i=i-1
      end
    end    
    i=i+1
  end  
  btimer=btimer+utime
  if btimer > bintv then
    table.insert(baddylist, {
      x = math.random(w/4, 3*(w/4)),
      y = 2,
      speed = utime*bsmp,
      timer = 0,
      dtimer = 0,
      pup = math.random(1,20)==5,
      frag = false
    })
	drawBaddie(baddylist[#baddylist])
    btimer=0
  end
end

function levelUp()
  level=level+1
  bintv=bintv-0.10
  bsmp=bsmp-0.5
  killc=0
  minterval=minterval-0.10
end

function updatePlayer(key)
  if powerup>0 then
    powerup = powerup-utime
  end

  if key==203 and plpos>1 then
	gpu.cursPos(plpos+1,h-1)
	gpu.write(" ")
    plpos=plpos-1
	drawPlayer()
  elseif key==205 and plpos<w then
	gpu.cursPos(plpos-1,h-1)
	gpu.write(" ")
    plpos=plpos+1
	drawPlayer()
  elseif key==57 then
    if powerup>0 then
      table.insert(projlist, {
        dir = -1,
        x = plpos+1,
        y = h-2
      })
	  drawProjectile(projlist[#projlist])
      table.insert(projlist, {
        dir = -1,
        x = plpos-1,
        y = h-2
      })
	  drawProjectile(projlist[#projlist])
    else
      table.insert(projlist, {
        dir = -1,
        x = plpos,
        y = h-2
      })
	  drawProjectile(projlist[#projlist])
    end
  end
end

gpu.clrBg("black")
drawWorld()
local wtimer cpu.startTimer(utime)
while not gameover do
  local e, v = iop.pullEvt()

  if e=="timer" then
    updateWorld()
    wtimer = cpu.startTimer(utime)
  elseif e=="key" then
    if v==28 then break end
    updatePlayer(v)
  end
end

gpu.cursPos(plpos-1, h-1)
if term.isColour() then gpu.setTxt("red") end
gpu.write("###")
local go = "Game Over!"
gpu.cursPos(w/2 - #go/2, 10)
if term.isColour() then gpu.setTxt("white") end
gpu.write(go)
gpu.cursPos(1,h)
cpu.sleep(5)
iop.rSetOutput("back", false)
gpu.clrBg("black")
