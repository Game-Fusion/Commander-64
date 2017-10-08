-- Simple test for QLink status

local modem = peripheral.find("modem")
modem.open(6464)
modem.transmit(6464,6464,{sType = "requestStatus"})
local t = os.startTimer(2)
while true do
  local e = {os.pullEvent()}
  if e[1] == "modem_message" then
    if e[3] == 6464 then
      if type(e[5]) == "table" then
        if e[5].sType then
          if e[5].sType == "status" then
            print("C64 Status: "..e[5].sContents)
          end
        end
      end
    end
  elseif e[1] == "timer" then
    print("C64 Status:")
    print("Error: Could not connect to server")
    break
  end
end
