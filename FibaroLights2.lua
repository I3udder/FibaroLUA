--[[
%% autostart
%% properties
%% weather
%% events
%% globals
DagNacht
--]]


-- Script to handle automatic lights on/off switch
-- Jeroen Vercoulen jeroen.vercoulen@gmail.com

-- This script requires a global variable name 'LightStatus' with values 0 and 1

local sourceTrigger = fibaro:getSourceTrigger();
function PowerOn()
local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
if (
 ( fibaro:getGlobalValue("DagNacht") == "Nacht" )
and
 ( (tonumber(os.date("%H%M")) >= tonumber(string.format("%02d%02d", "16", "00")) and tonumber(os.date("%H%M")) <= tonumber(string.format("%02d%02d", "23", "30"))) and (math.floor(os.time()/60)-math.floor(1495893600/60))%5 == 0 )
)
then
if (tonumber(LightStatus) == 0)
then
  -- disable continuously poweroff devices
  fibaro:setGlobal("LightStatus",1)
  -- You can specify as much lights you want. Just copy the line below.
  fibaro:call(6, "turnOn");
  fibaro:call(101, "turnOn");
  fibaro:call(8, "turnOn");
 end
 end

 end

if (sourceTrigger["type"] == "autostart") then
PowerOn()
else

local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
if (
startSource["type"] == "other"
)
then
	fibaro:call(6, "turnOn");
	fibaro:call(8, "turnOn");
	fibaro:call(101, "turnOn");
end

end
 
