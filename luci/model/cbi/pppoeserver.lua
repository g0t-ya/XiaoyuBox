--[[
LuCI - Lua Configuration Interface
]]--

local wa = require "luci.tools.webadmin"
local fs = require "nixio.fs"

local running=(luci.sys.call("pidof pppoe-server > /dev/null") == 0)
if running then	
	m = Map("pppoeserver", translate("PPPOE_Server"), translate("PPPOE_Server is running"))
else
	m = Map("pppoeserver", translate("PPPOE_Server"), translate("PPPOE_Server is not running"))
end

s = m:section(TypedSection, "global", translate("global"), translate("This is pppoe Server."))
s.addremove = false
s.anonymous = true

e = s:option(Flag, "enable", translate("PPPOE_Server"),translate("Enable or Disable Server."))
e.rmempty = false
e.default = e.enabled

s = m:section(TypedSection, "service", translate("pppoe server conf"))
s.addremove = false
s.anonymous = true

serverip = s:option(Value, "serverip", translate("Server IP","Server IP"),
	translate("PPPOE Server IP addr.   default: 10.0.1.1","PPPOE Server IP addr.   default: 10.0.1.1"))
serverip.default = "10.0.1.1"
serverip.optional = false
serverip.rmempty = false

clientip = s:option(Value, "clientip", translate("Client ip","Client ip"),
	translate("PPPOE Client IP addr.   default: 10.0.1.2-254","PPPOE Client IP addr.   default: 10.0.1.2-254"))
clientip.default = "10.0.1.2-254"
clientip.optional = false
clientip.rmempty = false

dns1 = s:option(Value, "dns1", translate("DNS1","DNS1"),
	translate("DNS IP addr. default: 10.0.1.1","DNS IP addr. default: 10.0.1.1"))
dns1.default = "10.0.1.1"
dns1.optional = false
dns1.rmempty = false

dns2 = s:option(Value, "dns2", translate("DNS2","DNS2"),
	translate("DNS IP addr. default: 8.8.8.8","DNS IP addr. default: 8.8.8.8"))
dns2.default = "8.8.8.8"
dns2.optional = false
dns2.rmempty = false

num = s:option(Value, "num", translate("Client num"),translate("PPPOE Client num.; default: 50"))
num.rmempty = true

mtu = s:option(Value, "mtu", translate("mtu"),translate("mtu; default: 1482"))
mtu.rmempty = true

mru = s:option(Value, "mru", translate("mru"),translate("mru; default: 1482"))
mru.rmempty = true

stimeout = s:option(Value, "timeout", translate("timeout"),translate("timeout"))
stimeout.rmempty = true


lcp_echo_failure = s:option(Value, "lcp_echo_failure", translate("lcp_echo_failure"),translate("lcp-echo-failure.; default: 2"))
lcp_echo_failure.rmempty = true

lcp_echo_interval = s:option(Value, "lcp_echo_interval", translate("lcp_echo_interval"),translate("lcp-echo-interval.; default: 10"))
lcp_echo_interval.rmempty = true

chap = s:option(Flag, "chap", translate("chap Encryption", "chap Encryption"),
	translate("Enable or Disable chap Encryption.","Enable or Disable chap Encryption."))
chap.default = true
chap.optional = false
chap.rmempty = false

nat = s:option(Flag, "nat", translate("NAT Forward", "NAT Forward"),
	translate("Enable or Disable NAT Forward.","Enable or Disable NAT Forward."))
nat.default = true
nat.optional = false
nat.rmempty = false

log = s:option(Value, "log", translate("log file","log file"),
	translate("pppoe server log file . default: /var/pppoe-server.log","pppoe server log file. default: /var/pppoe-server.log"))
log.default = "/var/pppoe-server.log"
log.optional = false
log.rmempty = false

s = m:section(TypedSection, "pppoeuser", translate("pppoe user pass etc."))
s.template = "cbi/tblsection"
s.addremove = true
s.anonymous = true

enable = s:option(Flag, "enable", translate("enable"))
enable.default = false
enable.optional = false
enable.rmempty = false

USERNAME = s:option(Value, "USERNAME", translate("USERNAME"),translate("USERNAME"))
USERNAME.rmempty = true

PROVIDER = s:option(Value, "PROVIDER", translate("PROVIDER"),translate("PROVIDER;default: *"))
PROVIDER.default = "*"
PROVIDER.rmempty = true

PASSWORD = s:option(Value, "PASSWORD", translate("PASSWORD"),translate("PASSWORD"))
PASSWORD.rmempty = true
PASSWORD.password = true

IPADDRESS = s:option(Value, "IPADDRESS", translate("IPADDRESS"),translate("IPADDRESS; default: *"))
IPADDRESS.default = "*"
IPADDRESS.rmempty = true

return m
