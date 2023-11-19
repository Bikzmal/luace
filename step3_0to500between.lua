PROCESS_NAME = "Tutorial-i386"
openProcess(PROCESS_NAME)

local scan = createMemScan()
scan.firstScan(soValueBetween, vtDword, rtTruncated, 0, 500, 0, 0xffffffffffffffff, "", fsmNotAligned, nil, false, false, false, false)
local foundlist = createFoundList(scan)
scan.waitTillDone()

for i = 1, 3 do
  inputQuery("Lose some hp and press enter", "", "")
  scan.nextScan(soDecreasedValue, vtDword, rtTruncated, nil, nil, false, false, false, false, false)
  scan.waitTillDone()
end

foundlist.initialize()

for i=0, foundlist.getCount() - 1 do
    local address = foundlist.getAddress(i)
    local value = foundlist.getValue(i)
    print(address .. ": " .. value)
    writeInteger(address, 5000)
end
