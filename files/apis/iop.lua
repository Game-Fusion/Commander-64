-- API made to replicate an input/output processor (IOP)'s functionality

-- OS functionality
function run(string)
  shell.run(string)
end

function loadAPI(api)
  os.loadAPI(api)
end

function unloadAPI(api)
  os.unloadAPI(api)
end

function pullEvt(string)
  os.pullEvent(string)
end

--pullEvt == pullEvent need to experiment before implementing

function pullEvtRaw(string)
  os.pullEventRaw(string)
end

--pullEvtRaw == pullEventRaw

-- FS management

function list(string)
  fs.list(string)
end

function getName(path)
  fs.getName(path)
end

function getDrive(path)
  fs.getDrive(path)
end

function getSize(path)
  fs.getSize(path)
end

function freeSpace(path)
  fs.getFreeSpace(path)
end

--freeSpace == getFreeSpace

function mkDir(path)
  fs.makeDir(path)
end

function move(from, to)
  fs.move(from, to)
end

function copy(from, to)
  fs.copy(from, to)
end

function delete(path)
  fs.delete(path)
end

function combine(base, local)
  fs.combine(base, local)
end

function open(path, rw)
  fs.open(path, rw)
end

function getDir(path)
  fs.getDir(path)
end

-- Disk

function diskPresent(side)
  disk.isPresent(side)
end

function diskHasData(side)
  disk.hasData(side)
end

function diskMountPath(side)
  disk.getMountPath(side)
end

function setDiskLabel(side)
  disk.setLabel(side)
end

function getDiskLabel(side)
  disk.getLabel(side)
end

function getDiskID(side)
  disk.getID(side)
end

function eject(side)
  disk.eject(side)
end

-- Peripherals

function pIsPresent(side)
  peripheral.isPresent(side)
end

function pGetType(side)
  peripheral.getType(side)
end

function pGetMethods(side)
  peripheral.getMethods(side)
end

function pCall(side, cmd)
  peripheral.call(side, cmd)
end

function pWrap(side)
  peripheral.wrap(side)
end

function pFind(type)
  peripheral.find(type)
end

function pGetNames()
  peripheral.getNames()
end

-- Redstone

function rGetSides()
  redstone.getSides()
end

function rGetInput(side)
  redstone.getInput(side)
end

function rSetOutput(side, bool)
  redstone.setOutput(side, bool)
end

function rGetOutput(side)
  redstone.getOutput(side)
end

function rGetAnalogInput(side)
  redstone.getAnalogInput(side)
end

function rSetAnalogOutput(side, strength)
  redstone.setAnalogOutput(side, strength)
end

function rGetAnalogOutput(side)
  redstone.getAnalogOutput(side)
end

function rGetBundledInput(side)
  redstone.getBundledInput(side)
end

function rGetBundledOutput
  redstone.getBundledOutput(side)
end

function rSetBundledOutput(side, col)
  redstone.setBundledOutput(side, colours.col)
end

function rTestBundledInput(side, col)
  redstone.testBundledInput(side, colours.col)
end

-- Misc

function getKeyName(code)
  keys.getName(code)
end
