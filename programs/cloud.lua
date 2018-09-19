-- Commodore Cloud
-- Based upon Revolution's GRID/Cloud
-- Powered by Q-Link

local function gridTitle()
  gpu.setTxt("white")
  gpu.clrBg("black")
  gpu.center(1,"Commodore Cloud")
  gpu.setBg("white")
  gpu.cursPos(1,2)
  gpu.clrLine()
  gpu.setBg("black")
end

local function terminated()
  gridTitle()
  gpu.center(4,"Sorry!")
  gpu.center(6,"Q-Link has been terminated.")
  gpu.center(7,"The Commodore Cloud service is unavailable.")
end

-- will check for QLink later, need to test

gridTitle()
gpu.center(4,"Welcome to Commodore Cloud!")
gpu.center(5,"This is the Commodore game streaming")
gpu.center(6,"service. You can stream great games straight")
gpu.center(7,"to your Commodore!")
sleep(2)

local function render()
  gridTitle()
  gpu.setTxt("white")
  gpu.center(5,"Select a Game:")
  gpu.center(7,"1. Cookie Clicker")
  gpu.center(9,"2. BATTLE")
  gpu.center(11,"3. Solitaire")
  gpu.center(13,"4. TRON")
  gpu.center(15,"5. Skyfall")
  gpu.center(17,"Press Space to exit")
end
render()
 
while true do local evt, button, x, y = os.pullEvent("keys")
if key == keys.one then
  gpu.clrBg("black")
  shell.run("pastebin run JknhWZ2a")
  render()
elseif key == keys.two then
  gpu.clrBg("black")
  shell.run("pastebin run MbvMiiCU")
  render()
elseif key == keys.three then
  gpu.clrBg("black")
  shell.run("pastebin run wg6xLisV")
  render()
elseif key == keys.four then
  gpu.clrBg("black")
  shell.run("pastebin run fuL9BpjX")
  render()
elseif key == keys.five then
  gpu.clrBg("black")
  shell.run("pastebin run mjyCbPks")
  render()
elseif key == keys.six then
  shell.run("/startup")
  render()
else end
end
