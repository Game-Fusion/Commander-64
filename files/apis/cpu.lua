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

-- Vector (will not include other vector functions because it may interfere with maths)

function vNew(1, 2, 3)
  vector.new(1, 2, 3)
end
