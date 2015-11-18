--[[
LuCI - Lua Configuration Interface

Copyright 2011

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id: crontab.lua 7785 2011-10-26 00:58:12Z jow $
]]--

require("luci.tools.webadmin")

local fs   = require "nixio.fs"
local util = require "nixio.util"

m = Map("cron", translate("Scheduled Tasks 2"),
	translate("This is the system crontab in which scheduled tasks can be defined."))


task = m:section(TypedSection, "task", "")
task.anonymous = true
task.addremove = true
task.template = "cbi/tblsection"
task.extedit  = luci.dispatcher.build_url("admin/system/crontab/crontableaf/%s")

task.create = function(...)
	local sid = TypedSection.create(...)
	if sid then
		luci.http.redirect(task.extedit % sid)
		return
	end
end


enable=task:option(Flag, "enabled", translate("Enable"))
enable.default = false
enable.optional = false
enable.rmempty = false
enable.disabled = 0


task_task_task=task:option(DummyValue, "task_name", translate("task name"))
function task_task_task.cfgvalue(self, s)
	return self.map:get(s, "task_name") or "none"
end

task_time = task:option(DummyValue, "task_time", translate("task time","task time"))
task_time.optional = false
task_time.rmempty = false
function task_time.cfgvalue(self, s)
	return self.map:get(s, "task_time")
end

task_task = task:option(DummyValue, "task_task", translate("task command","task command"))
task_task.optional = false
task_task.rmempty = false
function task_task.cfgvalue(self, s)
	return self.map:get(s, "task_task")
end

return m
