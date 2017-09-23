-- API for managing processor tasks
-- Including but not limited to calculations and process management

-- Bit API for bitwise binary manipulation
-- Bit already had simple syntax so it's largely the same

function blshift(n, bit) -- Shifts a number left by a specified number of bits
  bit.blshift(n, bit)
end

function brshift(n, bit) -- Shifts a number right arithmetically by a specified number of bits
  bit.brshift(n, bit)
end

function blogic_rshift(n, bit) -- Shifts a number right logically by a specified number of bits
  bit.blogic_rshift(n, bit)
end

function bxor(m, n) -- Computes the bitwise exclusive OR of two numbers
  bit.bxor(m, n)
end

function bor(m, n) --  Computes the bitwise inclusive OR of two numbers
  bit.bor(m, n)
end

function band(m, n) -- Computes the bitwise AND of two numbers
  bit.band(m, n)
end

function bnot(n) -- Computes the bitwise NOT of a number
  bit.bnot(n)
end

-- Parallel functions
-- Syntax intact for convenience

function waitForAny(1, 2) -- Only 2 for now - will eventually get infinite threads
  parallel.waitForAny(1, 2)
end

function waitForAll(1, 2)
  parallel.waitForAll(1, 2)
end

-- Multishell support for future multithreading/multishell(?)
-- Multishell commands begin with t to indicate threading/multishell + to avoid conflicts

function tGetTitle(tab)
  multishell.getTitle(tab)
end

function tGetCount()
  multishell.getCount()
end

function tLaunch(env, path)
  multishell.launch(env, path)
end

function tSetFocus(tab)
  multishell.setFocus(tab)
end

function tSetTitle(tab, title)
  multishell.setTitle(tab, title)
end

function tGetTitle(tab)
  multishell.getTitle(tab)
end

function tGetFocus(tab)
  multishell.getFocus(tab)
end

-- Other processes
-- eg. GPS, encoding and serialization

function serialize(data)
  textutils.serialize(data)
end

function unserialize(data)
  textutils.unserialize(data)
end

function serializeJSON(data)
  textutils.serializeJSON(data)
end

function urlEncode(url)
  textutils.urlEncode(url)
end

function locate(timeout)
  gps.locate(timeout)
end
