--[[
%% autostart
%% properties
%% globals
--]]

-- Script to handle automatic lights on/off switch
-- Jeroen Vercoulen jeroen.vercoulen@gmail.com

-- This script requires a global variable name 'LightStatus' with values 0 and 1

local sourceTrigger = fibaro:getSourceTrigger();
function PowerOff()
local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
if (
 ( string.format("%02d:%02d", currentDate.hour, currentDate.min) == "23:59" ) -- You can specify any time to poweroff the lights
)
then
if (tonumber(LightStatus) == 1)
then
  -- disable continuously poweroff devices
  fibaro:setGlobal("LightStatus",0)
  -- You can specify as much lights you want. Just copy the line below.
  fibaro:call(6, "turnOff");
  fibaro:call(101, "turnOff");
 end
 end
 if (
 ( string.format("%02d:%02d", currentDate.hour, currentDate.min) == "21:00" ) -- You can specify any time to poweroff the lights
)
then
  -- You can specify as much lights you want. Just copy the line below.
  fibaro:call(8, "turnOff");
end

 end

if (sourceTrigger["type"] == "autostart") then
PowerOff()
else

local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
if (
startSource["type"] == "other"
)
then
	fibaro:call(6, "turnOff");
	fibaro:call(8, "turnOff");
	fibaro:call(101, "turnOff");
end

end
 