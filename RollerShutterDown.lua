--[[
%% autostart
%% properties
70 value
125 Temperature
%% weather
%% events
%% globals
DagNacht
--]]

local sourceTrigger = fibaro:getSourceTrigger();
function RollerShutterDown()
local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();

if( tonumber(fibaro:getValue(70, "value")) >= 23  and  tonumber(fibaro:getValue(125, "Temperature")) >= 23 and fibaro:getGlobalValue("rolluiken") == 0 ) 
then
	fibaro:call(17, "close");
	fibaro:call(18, "close");
	fibaro:call(20, "close");
	fibaro:call(19, "close");
	fibaro:setGlobal("rolluiken", "1");
else
  if ((
   ( (tonumber(os.date("%H%M")) >= tonumber(string.format("%02d%02d", "23", "01")) and tonumber(os.date("%H%M")) <= tonumber(string.format("%02d%02d", "23", "02"))) and (math.floor(os.time()/60)-math.floor(1502139660/60))%1 == 0 )
  or
   ( (tonumber(os.date("%H%M")) >= tonumber(string.format("%02d%02d", "18", "00")) and tonumber(os.date("%H%M")) <= tonumber(string.format("%02d%02d", "22", "55"))) and (math.floor(os.time()/60)-math.floor(1502121600/60))%15 == 0  and  fibaro:getGlobalValue("DagNacht") == "Nacht" )
  )
  and
   fibaro:getGlobalValue("rolluiken") == 0 )
  then
	fibaro:call(17, "close");
	fibaro:call(18, "close");
	fibaro:call(20, "close");
	fibaro:call(19, "close");
	fibaro:setGlobal("rolluiken", "1");
  end
end
  setTimeout(RollerShutterDown, 60*1000)
end

if (sourceTrigger["type"] == "autostart") then
RollerShutterDown()
else

local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
if startSource["type"] == "other"
then
  fibaro:call(17, "close");
  fibaro:call(18, "close");
  fibaro:call(20, "close");
  fibaro:call(19, "close");
end

end
  