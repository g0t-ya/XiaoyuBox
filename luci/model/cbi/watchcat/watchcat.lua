--[[
LuCI - Lua Configuration Interface

Copyright 2012 Christian Gagneraud <chris@techworks.ie>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--
local fs = require "nixio.fs"

local running=(luci.sys.call("pidof watchcat.sh > /dev/null") == 0)
if running then	
	m = Map("system", translate("Watchcat"), translate("Watchcat is running"))
else
	m = Map("system", translate("Watchcat"), translate("Watchcat is not running"))
end

s = m:section(TypedSection, "switch", translate("config"),
	translate("Watchcat allows configuring a periodic reboot when the " ..
		  "Internet connection has been lost for a certain period of time."
		 ))
s.anonymous = true
s.addremove = false

e = s:option(Flag, "enabled", translate("Enable"), translate("Enable or disable watchcat."))
e.rmempty = false
e.default = e.enabled

s = m:section(TypedSection, "watchcat")
s.anonymous = true
s.addremove = true

mode = s:option(ListValue, "mode", translate("Operating mode"))
mode.default = "allways"
mode:value("ping", translate("Reboot on internet connection lost"))
mode:value("allways", translate("Periodic reboot"))

forcedelay = s:option(Value, "forcedelay", translate("Forced reboot delay"),
		      translate("When rebooting the system, the watchcat will trigger a soft reboot. " ..
				"Entering a non zero value here will trigger a delayed hard reboot " ..
				"if the soft reboot fails. Enter a number of seconds to enable, " ..
				"use 0 to disable"))
forcedelay.datatype = "uinteger"
forcedelay.default = "0"

period = s:option(Value, "period", translate("Period"),
		  translate("In periodic mode, it defines the reboot period. " ..
			    "In internet mode, it defines the longest period of " .. 
			    "time without internet access before a reboot is engaged." ..
			    "Default unit is seconds, you can use the " ..
			    "suffix 'm' for minutes, 'h' for hours or 'd' " ..
			    "for days"))

pinghosts = s:option(Value, "pinghosts", translate("Ping host"),
		    translate("Host address to ping"))
pinghosts.datatype = "host"
pinghosts.default = "8.8.8.8"
pinghosts:depends({mode="ping"})

pingperiod = s:option(Value, "pingperiod", translate("Ping period"),
		      translate("How often to check internet connection. " ..
				"Default unit is seconds, you can you use the " ..
				"suffix 'm' for minutes, 'h' for hours or 'd' " ..
				"for days"))
pingperiod:depends({mode="ping"})

return m
