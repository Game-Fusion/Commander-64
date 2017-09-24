-- API made to replicate an input/output processor (IOP)'s functionality
-- By Mr_Iron2 and MultMine

-- OS functionality

run = shell.run

loadAPI = os.loadAPI

unloadAPI = os.unloadAPI

pullEvt = os.pullEvent

pullEvent = os.pullEvent

pullEventRaw == os.pullEventRaw

pullEvtRaw = os.pullEventRaw

-- FS management

list = fs.list

getName = fs.getName

getDrive = fs.getDrive

getSize = fs.getSize

freeSpace = fs.getFreeSpace

mkDir = fs.makeDir

move = fs.move

copy = fs.copy

delete = fs.delete

combine = fs.combine

open = fs.open

getDir = fs.getDir

-- Disk

diskPresent = disk.isPresent

diskHasData = disk.hasData

diskMountPath = disk.getMountPath

setDiskLabel = disk.setLabel

getDiskLabel = disk.getLabel

getDiskID = disk.getID

eject = disk.eject

-- Peripherals

pIsPresent = peripheral.isPresent

pGetType = peripheral.getType

pGetMethods = peripheral.getMethods

pCall = peripheral.call

pWrap = peripheral.wrap

pFind = peripheral.find

pGetNames = peripheral.getNames

-- Redstone

rGetSides = rs.getSides

rGetInput = rs.getInput

rSetOutput = rs.setOutput

rGetOutput = rs.getOutput

rGetAnalogInput = rs.getAnalogInput

rSetAnalogOutput = rs.setAnalogOutput

rGetAnalogOutput = rs.getAnalogOutput

rGetBundledInput = rs.getBundledInput

rGetBundledOutput = rs.getBundledOutput

rSetBundledOutput = rs.setBundledOutput

rTestBundledInput = rs.testBundledInput

-- Modem I/O

mIsOpen = modem.isOpen

openModem = modem.open

mOpen = modem.open --alias

closeModem = modem.close

mClose = modem.close

mCloseAll = modem.closeAll

closeAllModems = modem.closeAll

mCallRemote = modem.callRemote

mIsWireless = modem.isWireless

isModemWireless = modem.isWireless

mIsPresentRemote = modem.isPresentRemote

-- Misc

getKeyName = keys.getName
