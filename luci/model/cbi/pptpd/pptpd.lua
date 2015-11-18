--[[
LuCI - Lua Configuration Interface
modified by rapistor
]]--

local wa = require "luci.tools.webadmin"
local fs = require "nixio.fs"

local running=(luci.sys.call("pidof pptpd > /dev/null") == 0)
if running then	
	m = Map("pptpd", translate("PPTPD"), translate("pptpd is running"))
else
	m = Map("pptpd", translate("PPTPD"), translate("pptpd is not running"))
end

s = m:section(TypedSection, "service", translate("VPN Server: General Settings"), translate("This is PPTP VPN Server."))
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("enable"),translate("Enable or Disable VPN Server."))
enable.rmempty = false
function enable.write(self, section, value)
	if value == "1" then
		luci.sys.init.enable("pptpd")
		luci.sys.call("/etc/init.d/pptpd start >/dev/null")
	else
		luci.sys.call("/etc/init.d/pptpd stop >/dev/null")
		luci.sys.init.disable("pptpd")
	end
	return Flag.write(self, section, value)
end

serverip = s:option(Value, "serverip", translate("Server IP"),translate("VPN Server IP addr. ; default: 10.0.0.1"))
serverip.datatype = "ipaddr"
serverip.placeholder = translate("10.0.0.1")
serverip.rmempty = true
serverip.default = ""

clientip = s:option(Value, "clientip", translate("Client ip"),translate("VPN Client IP addr.; default: 10.0.0.2-254"))
clientip.placeholder = translate("10.0.0.2-254")
clientip.rmempty = true
clientip.default = ""

dns1 = s:option(Value, "dns1", translate("DNS1"),translate("DNS1 IP addr.; default: 10.0.0.1"))
dns1.placeholder = translate("10.0.0.1")
dns1.datatype = "ipaddr"

dns2 = s:option(Value, "dns2", translate("DNS2"),translate("DNS2 IP addr.; default: 8.8.8.8"))
dns2.placeholder = translate("8.8.8.8")
dns2.datatype = "ipaddr"

mppe = s:option(Flag, "mppe", translate("MPPE Encryption"),translate("Enable or Disable  MPPE Encryption."))
nat = s:option(Flag, "nat", translate("NAT Forward"),translate("Enable or Disable  NAT Forward."))

s = m:section(TypedSection, "user", translate("ppptpd user pass etc."))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

enable = s:option(Flag, "enable", translate("enable", "enable"))
enable.default = false
enable.optional = false
enable.rmempty = false

USERNAME = s:option(Value, "USERNAME", translate("Username"), translate("Username"))
USERNAME.optional = false
USERNAME.rmempty = false

PASSWORD = s:option(Value, "PASSWORD", translate("Password"), translate("Password"))
PASSWORD.rmempty = false
PASSWORD.password = true

IPADDRESS = s:option(Value, "IPADDRESS", translate("Ipaddress"), translate("Ipaddress;default: *"))
IPADDRESS.default = "*"
IPADDRESS.optional = false
IPADDRESS.rmempty = false

return m

