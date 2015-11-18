
local sys = require "luci.sys"
local wan_ifname = luci.util.exec("uci get network.wan.ifname")
local lan_ifname = luci.util.exec("uci get network.lan.ifname")
local fs = require "nixio.fs"

local running=(luci.sys.call("pidof pppoe-relay > /dev/null") == 0)
if running then	
	m = Map("pppoe-relay", translate("pppoe-relay"), translate("pppoe-relay is running"))
else
	m = Map("pppoe-relay", translate("pppoe-relay"), translate("pppoe-relay is not running"))
end

s = m:section(TypedSection, "config", translate("Settings"), translate("pppoe-relay is a user-space relay agent for PPPoE (Point-to-Point Protocol over Ethernet) for Linux. "))
s.addremove = false
s.anonymous = true

e = s:option(Flag, "enabled", translate("Enable"))
e.rmempty = false
e.default = e.enabled

timeout = s:option(Value, "timeout", translate("timeout"),translate("timeout(seconds).Default Value:600"))
timeout.rmempty = true
timeout.default ="600"
timeout:value("600")

max_n_sessions = s:option(Value, "max_n_sessions", translate("max_number_sessions"),translate("Maxmimum number of sessions to relay.Default Value:5000"))
max_n_sessions.rmempty = true
max_n_sessions.default ="5000"
max_n_sessions:value("5000")

s = m:section(TypedSection, "relay", translate("Settings"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

enable = s:option(Flag, "enabled", translate("enable", "enable"))
enable.optional = false
enable.rmempty = false

two_way_relay = s:option(Flag, "two_way_relay", translate("two_way_relay"))
two_way_relay.optional = false
two_way_relay.rmempty = false

s_if_name = s:option(Value, "s_if_name", translate("Specify interface for PPPoE Server"))
s_if_name.optional = false
s_if_name.rmempty = false
s_if_name.default = wan_ifname 
s_if_name:value(wan_ifname,wan_ifname .. "[wan]")
s_if_name:value(lan_ifname,lan_ifname .. "[lan]")

c_if_name= s:option(Value, "c_if_name", translate("Specify interface for PPPoE Client"))
c_if_name.default = "br-lan"
c_if_name.optional = false
c_if_name.rmempty = false

c_if_name:value(wan_ifname,wan_ifname .. '[wan]')
c_if_name:value(lan_ifname,lan_ifname .. '[lan]')

for _, e in ipairs(sys.net.devices()) do
	if e ~= "lo" then s_if_name:value(e) end
	if e ~= "lo" then c_if_name:value(e) end
end

return m
