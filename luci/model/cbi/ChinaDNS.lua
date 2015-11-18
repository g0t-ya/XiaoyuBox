--[[
openwrt-dist-luci: ChinaDNS
]]--

local fs = require "nixio.fs"
local m, s, o

if luci.sys.call("pidof chinadns >/dev/null") == 0 then
	m = Map("chinadns", translate("ChinaDNS"), translate("ChinaDNS is running"))
else
	m = Map("chinadns", translate("ChinaDNS"), translate("ChinaDNS is not running"))
end

s = m:section(TypedSection, "chinadns", translate("General Setting"))
s.anonymous = true

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty = false

o = s:option(Flag, "automod", translate("automod"), translate("Modified config files automatically, do not unselect it unless you know what you are doing."))
o.rmempty = false

o = s:option(Flag, "compression", translate("Enable Compression Pointer"),
	translate("Using DNS compression pointer mutation, backlist and delaying would be disabled"))
o.rmempty = false

o = s:option(Flag, "bidirectional", translate("Enable Bidirectional Filter"),
	translate("Also filter results inside China from foreign DNS servers"))
o.rmempty = false

o = s:option(Value, "port", translate("Local Port"))
o.placeholder = 5353
o.default = 5353
o.datatype = "port"
o.rmempty = false

o = s:option(Value, "iplist", translate("Fake IP List"))
o.placeholder = "/etc/chinadns_iplist.txt"
o.default = "/etc/chinadns_iplist.txt"
o.datatype = "file"
o:depends("compression", "")

o = s:option(Value, "chnroute", translate("CHNRoute File"))
o.placeholder = "/etc/chinadns_chnroute.txt"
o.default = "/etc/chinadns_chnroute.txt"
o.datatype = "file"
o.rmempty = false

o = s:option(Value, "server", translate("Upstream Servers"),
	translate("Use commas to separate multiple ip address"))
o.default = "114.114.114.114,208.67.222.222:443,8.8.8.8"
o:value("114.114.114.114,208.67.222.222:443,8.8.8.8")
o:value("114.114.114.114,8.8.4.4")
o:value("114.114.114.114,8.8.8.8")
o:value("114.114.114.114,208.67.222.222")
o:value("114.114.114.114,208.67.220.220")
o:value("114.114.114.114,178.79.131.110")
o:value("114.114.114.114,199.91.73.222")
o:value("114.114.114.114,127.0.0.1:2053")
o.rmempty = false

o = s:option(Value, "result_delay", translate("Delay Time(sec)"),
	translate("Delay time for suspects, default: 0.3"))
o.placeholder = 0.3
o.default = 0.3
o.datatype = "ufloat"
o:depends("compression", "")

iplist = s:option(Value, "iplists", translate("IP blacklist"), "")
iplist.template = "cbi/tvalue"
iplist.size = 30
iplist.rows = 10
iplist.wrap = "off"

function iplist.cfgvalue(self, section)
	return fs.readfile("/etc/chinadns_iplist.txt") or ""
end
function iplist.write(self, section, value)
	if value then
		value = value:gsub("\r\n?", "\n")
		fs.writefile("/etc/chinadns_iplist.txt", value)
	end
end

chn = s:option(Value, "chn", translate("CHNroute"), "")
chn.template = "cbi/tvalue"
chn.size = 30
chn.rows = 10
chn.wrap = "off"

function chn.cfgvalue(self, section)
	return fs.readfile("/etc/chinadns_chnroute.txt") or ""
end
function chn.write(self, section, value)
	if value then
		value = value:gsub("\r\n?", "\n")
		fs.writefile("/etc/chinadns_chnroute.txt", value)
	end
end

button_update = s:option(Button, "_button", translate("update_chinadns_chnroute"), translate("Manual update chinadns_chnroute."))
button_update.inputtitle = translate("execute Manual_Update")
button_update.inputstyle = "apply"

function button_update.write(self, section)
	os.execute('/lib/chinadns/update start &')
	self.inputtitle = translate("execute Manual_Update")
end

return m
