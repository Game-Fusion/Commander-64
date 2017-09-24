-- Minimalist graphics API by Mr_Iron2 for Commander 64
-- Essentials from term, window, paintutils and textutils
-- Cleaned up and fixed by MultMine

-- Basic clear and colour functions

blit = term.blit

clr = term.clear

function center(y, str)
  local w,h = term.getSize()
  local x = (w/2)-(#str/2)
  term.setCursorPos(x,y)
  print(str)
end

cursPos = term.setCursorPos

cursBlink = term.setCursorBlink

function centerSlow(y, str)
  local w,h = term.getSize()
  local x = (w/2)-(#str/2)
  term.setCursorPos(x,y)
  textutils.slowPrint(str)
end

bg = term.setBackgroundColour

function setBg(col) -- thanks to MultMine for fix
  term.setBackgroundColour(colours[col])
end

function setTxt(col)
  term.setTextColour(colours[col])
end

function clrBg(back)
  term.setBackgroundColour(colours[back])
  term.clear()
end

function clrLine(y)
  term.setCursorPos(1,y)
  term.clearLine()
end

-- Window/display commands

winSize = term.getSize

newWindow = window.create

current = term.current

redirect = term.redirect

function setVis(bool)
  local func = term.current().setVisible
  if func then
    func(bool)
  end
end

function redraw()
  local func = term.current().redraw
  if func then
    func()
  end
end

function monTxtScale(size)
  local func = term.current().setTextScale
  if func then
    func(size)
  end
end

-- Paintutils derived commands

loadImg = paintutils.loadImage

drawImg = paintutils.drawImage

function drawPixel(x, y, col)
  paintutils.drawPixel(x, y, colours[col])
end

function drawLine(x1, y1, x2, y2, col)
  paintutils.drawLine(x1, y1, x2, y2, colours[col])
end

function drawBox(x1, y1, x2, y2, col)
  paintutils.drawBox(x1, y1, x2, y2, colours[col])
end

function drawFilledBox(x1, y1, x2, y2, col)
  paintutils.drawFilledBox(x1, y1, x2, y2, colours[col])
end

-- Textutils commands

slowWrite = textutils.slowWrite

slowPrint = textutils.slowPrint
