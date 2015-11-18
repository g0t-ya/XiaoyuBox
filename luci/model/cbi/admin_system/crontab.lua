--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008-2013 Jo-Philipp Wich <xm@subsignal.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

local fs = require "nixio.fs"
local cronfile = "/etc/crontabs/root" 

m = Map("crontab",  translate("Scheduled Tasks"), translate("This is the system crontab in which scheduled tasks can be defined."))

s = m:section(TypedSection, "command", translate("Task Command"), translate("Please press Enter key after you type your commands."))
s.anonymous = true

editfile = s:option(TextValue, "editfile")
editfile.template = "cbi/tvalue"
editfile.rows = 10
editfile.wrap = "off"

function editfile.cfgvalue(self, section)
	return fs.readfile(cronfile) or ""
end

function editfile.write(self, section, value)
--	if state == FORM_VALID then
		if value then
			value = value:gsub("\r\n", "\n")
			fs.writefile(cronfile, value)
			luci.sys.call("/usr/bin/crontab %q" % cronfile)
--		end
	end
	return true
end

s = m:section(TypedSection,"settings", translate("setting"), translate("Add some custom commands below,will be effective after reboot."))
s.anonymous = true
s.addremove = false

enable = s:option(Flag, "memory_clear", translate("memory_clear"), translate("Regularly clean up the memory."))
enable.default = 0
enable.rmempty = false
enable.default = enable.enabled

enable = s:option(Flag, "timing", translate("timing"), translate("Automatic time correction."))
enable.default = 0
enable.rmempty = false

return m
