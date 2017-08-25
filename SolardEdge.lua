--[[
%% properties
%% events
%% globals
--]]

local sourceTrigger = fibaro:getSourceTrigger();
function process(response)
local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
local http = net.HTTPClient()

http:request("https://monitoringapi.solaredge.com/site/<Site ID>/overview.json?api_key=<API KEY>",{
options = {method = 'GET'},
success = process,
 error = error
 })

if response then
 if response.status~= 200 then
 fibaro:debug("Error")
else
 --fibaro:debug("Response Data: ".. response.data)
 jsonData = response.data
 jsonTable = json.decode(jsonData)
 fibaro:call(149, "setProperty", "ui.Usage1.value" , jsonTable.overview.currentPower.power /1000 .." kWh")
 fibaro:call(149, "setProperty", "ui.Usage2.value" , jsonTable.overview.lastDayData.energy /1000 .." kWh")
 fibaro:call(149, "setProperty", "ui.Usage3.value" , jsonTable.overview.lastMonthData.energy /1000 .." kWh")
 fibaro:call(149, "setProperty", "ui.Usage4.value" , jsonTable.overview.lastYearData.energy /1000000 .." MWh")
 fibaro:call(149, "setProperty", "ui.Usage5.value" , jsonTable.overview.lifeTimeData.energy /1000000 .." MWh")
 fibaro:sleep(300000)
end

end
setTimeout(process, 60*1000)

end

if (sourceTrigger["type"] == "autostart") then
  process()
else
  local currentDate = os.date("*t");
  local startSource = fibaro:getSourceTrigger();
if (
startSource["type"] == "other"
)
then
 process()
end

end
