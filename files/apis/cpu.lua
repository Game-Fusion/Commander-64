-- API for managing processor tasks
-- Including but not limited to calculations and process management
-- By Mr_Iron2 and MultMine

local version = 1.1

-- Basic math functionality

randomInt = math.random -- Random integer between X and Y, ie. cpu.randomInt(1, 100)

sqrt = math.sqrt -- Square root of a number

-- Bit API for bitwise binary manipulation

blshift = bit.blshift -- Shifts a number left by a specified number of bits

brshift = bit.brshift -- Shifts a number right arithmetically by a specified number of bits

blogic_rshift = bit.blogic_rshift -- Shifts a number right logically by a specified number of bits

bxor = bit.bxor -- Computes the bitwise exclusive OR of two numbers

bor = bit.bor --  Computes the bitwise inclusive OR of two numbers

band = bit.band -- Computes the bitwise AND of two numbers

bnot = bit.bnot -- Computes the bitwise NOT of a number

-- Parallel functions
-- Syntax intact for convenience

waitForAny = parallel.waitForAny -- infinite threads

waitForAll = parallel.waitForAll -- wait for all processes before proceeding

-- Multishell support for future multithreading/multishell(?)
-- Multishell commands begin with t to indicate threading/multishell + to avoid conflicts

if multishell then
  tGetTitle = multishell.getTitle
  tGetCount = multishell.getCount
  tLaunch = multishell.launch
  tSetFocus = multishell.setFocus
  tSetTitle = multishell.setTitle
  tGetFocus = multishell.getFocus
  
else
  tGetTitle = function()
    return ""
  end
  
  tGetCount = function()
    return 1
  end
  
  tLaunch = function()
    return false
  end
  
  tSetFocus = function()
    return true
  end
  
  tSetTItle = function()
    return false
  end
  
  tGetFocus = function()
    return 1
  end
end

-- Other processes
-- eg. GPS, encoding and serialization

startTimer = os.startTimer

clock = os.clock

cancelTimer = os.cancelTimer

sleep = os.sleep

serialize = textutils.serialize

unserialize = textutils.unserialize

serializeJSON = textutils.serializeJSON

urlEncode = textutils.urlEncode

locate = gps.locate
