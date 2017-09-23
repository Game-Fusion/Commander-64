-- Minimalist graphics API by Mr_Iron2 for Commander 64
-- Essentials from term, window, paintutils and textutils

-- Basic clear and colour functions

function blit(text, textcol, backcol)
  term.blit(text, textcol, backcol)
end

function clr()
  term.clear()
end

function center(y, string)
  local w,h = term.getSize()
  local x = (w/2)-(#string/2)
  term.setCursorPos(x,y)
  print(string)
end

function cursPos(x,y)
  term.setCursorPos(x,y)
end

function centerSlow(y, string)
  local w,h = term.getSize()
  local x = (w/2)-(#string/2)
  term.setCursorPos(x,y)
  textutils.slowPrint(string)
end

function setBg(col)
  term.setBackgroundColour(colours.col)
end

function setTxt(col)
  term.setTextColour(colours.col)
end

function clrBg(back)
  term.setBackgroundColour(colours.back)
  term.clear()
end

function clrLine(y)
  term.setCursorPos(1,y)
  term.clearLine()
end

-- Window/display commands

function winSize()
  term.getSize()
end

function newWindow(parent, x, y, w, h)
  window.create(parent, x, y, w, h)
end

function current()
  term.current()
end

function redirect(target)
  term.redirect(target)
end

function setVis(bool)
  window.setVisible(bool)
end

function redraw()
  window.redraw()
end

function monTxtScale(size)
  monitor.setTextScale(size)
end

-- Paintutils derived commands

function loadImg(src)
  paintutils.loadImage(src)
end

function drawImg(img, x, y)
  paintutils.drawImage(img, x, y)
end

function drawPixel(x, y)
  paintutils.drawPixel(x, y)
end

function drawLine(x1, y1, x2, y2, col)
  paintutils.drawLine(x1, y1, x2, y2, colours.col)
end

function drawBox(x1, y1, x2, y2, col)
  paintutils.drawBox(x1, y1, x2, y2, colours.col)
end

function drawFilledBox(x1, y1, x2, y2, col)
  paintutils.drawFilledBox(x1, y1, x2, y2, colours.col)
end

-- Textutils commands

function slowWrite(text, spd)
  textutils.slowWrite(text, spd)
end

function slowPrint(text, spd)
  textutils.slowPrint(text, spd)
end
