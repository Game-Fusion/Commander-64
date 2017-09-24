-- API for managing processor tasks
-- Including but not limited to calculations and process management

-- Bit API for bitwise binary manipulation
-- Bit already had simple syntax so it's largely the same

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

waitForAll = parallel.waitForAll

-- Multishell support for future multithreading/multishell(?)
-- Multishell commands begin with t to indicate threading/multishell + to avoid conflicts

tGetTitle = multishell.getTitle

tGetCount = multishell.getCount

tLaunch = multishell.launch

tSetFocus = multishell.setFocus

tSetTitle = multishell.setTitle

tGetFocus = multishell.getFocus

-- Other processes
-- eg. GPS, encoding and serialization

sleep = os.sleep

serialize = textutils.serialize

unserialize = textutils.unserialize

serializeJSON = textutils.serializeJSON

urlEncode = textutils.urlEncode

locate = gps.locate
