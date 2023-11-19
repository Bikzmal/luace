PROCESS_NAME = "Tutorial-i386"
openProcess(PROCESS_NAME)

-- FUNCTION TO CHANGE ALL ADDRESSES VALUES IN A FOUNDLIST
function changeAddressesValues(foundlist, x, ftype)
    for i=0, foundlist.getCount() - 1 do
      local address = foundlist.getAddress(i)
      local value = foundlist.getValue(i)
      print(address .. ": " .. value .. " -> " .. x)
      if ftype == "Float" then
         writeFloat(address, x)
      elseif ftype == "Double" then
         writeDouble(address, x)
      elseif ftype == "Int" then
         writeInteger(address, x)
      end
    end
end

-- TEMPLATE STUFF | INITIALIZE MEMSCAN + FOUNDLIST
local scan = createMemScan()
local foundlist = createFoundList(scan)

-- ASK HP, THEN EXACT VALUE SCAN ON HP VALUE
local hp = tonumber(inputQuery("Enter your hp", "", "100"))
scan.firstScan(soExactValue, vtSingle, rtTruncated, hp, nil, 0, 0xffffffffffffffff, "", fsmNotAligned, nil, false, false, false, false)
scan.waitTillDone()

-- LOSE HP, THEN LOOK FOR DECREASED VALUE
inputQuery("Lose some hp then enter", "", "")

scan.nextScan(soDecreasedValue, vtSingle, rtTruncated, nil, nil, false, false, false, false, false)
scan.waitTillDone()

-- INITIALIZE FOUNDLIST, THEN CALL CHANGEADDRESSESVALUES WITH ARGS
foundlist.initialize()

changeAddressesValues(foundlist, 5000, "Float")

-- CLEAR MEMSCAN AND FOUNDLIST
foundlist.deinitialize()
scan.newScan()

-- ASK AMMO, THEN EXACT VALUE SCAN ON AMMO VALUE
local ammo = tonumber(inputQuery("Enter your ammo", "", "100"))
scan.firstScan(soExactValue, vtDouble, rtTruncated, ammo, nil, 0, 0xffffffffffffffff, "", fsmNotAligned, nil, false, false, false, false)
scan.waitTillDone()

-- LOSE AMMO, THEN LOOK FOR DECREASED VALUE
inputQuery("Lose some ammo then enter", "", "")

scan.nextScan(soDecreasedValue, vtDouble, rtTruncated, nil, nil, false, false, false, false, false)
scan.waitTillDone()

-- INITIALIZE FOUNDLIST, THEN CALL CHANGEADDRESSESVALUES WITH ARGS
foundlist.initialize()

changeAddressesValues(foundlist, 5000, "Double")
