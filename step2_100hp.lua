PROCESS_NAME = "Tutorial-i386"
openProcess(PROCESS_NAME)


local hp = tonumber(inputQuery("Type ur hp rq", "", "100"))
local scan = createMemScan()
scan.firstScan(soExactValue, vtDword, rtTruncated, hp, nil, 0, 0xffffffffffffffff, "", fsmNotAligned, nil, false, false, false, false)
local foundlist = createFoundList(scan)
scan.waitTillDone()

inputQuery("Lose some hp and press enter", "", "")
scan.nextScan(soDecreasedValue, vtDword, rtTruncated, hp, nil, 0, 0xffffffffffffffff, "", fsmNotAligned, nil, false, false, false, false)
scan.waitTillDone()

foundlist.initialize()

for i=0, foundlist.getCount() - 1 do
    local address = foundlist.getAddress(i)
    local value = foundlist.getValue(i)
    print(address .. ": " .. value)
    writeInteger(address, 1000)
end
