--[[
openwrt-dist-luci: ShadowSocks
]]--

local fs = require "nixio.fs"

local sslocal =(luci.sys.call("pidof ss-local > /dev/null") == 0)
local ssredir =(luci.sys.call("pidof ss-redir > /dev/null") == 0)
if sslocal or ssredir then
	m = Map("shadowsocks", translate("ShadowSocks"), translate("ShadowSocks is running"))
else
	m = Map("shadowsocks", translate("ShadowSocks"), translate("ShadowSocks is not running"))
end


-- Global Setting
s = m:section(TypedSection, "shadowsocks", translate("Global Setting"), translate("<p>如需帮助:<a target=\"_blank\" href=\"http://myop.ml/archives/category/firmware-guide/\">请查看使用教程</a></p>"))
s.anonymous = true

o = s:option(Flag, "enable", translate("Enable"))
o.default = 1
o.rmempty = false

o = s:option(Value, "sleep_time", translate("Sleep_time before start"),translate("The number of seconds to wait before Shadowsocks start(Seconds)."))
o:value("20", "20")
o:value("30", "30")
o:value("40", "40")
o:value("50", "50")
o:value("60", "60")
o.default = "20"
o.optional = true
o.rmempty = true

o = s:option(Flag, "redir_enable", translate("Global Enable"), translate("Enable Global Proxy."))
o.default = 0
o.rmempty = false

o = s:option(Flag, "local_enable", translate("SOCK5 Enable"), translate("Enable SOCK5 Proxy."))
o.default = 0
o.rmempty = false

o = s:option(Value, "ss_local_port", translate("SOCK5 Port"), translate("SOCK5 port."))
o.datatype = "port"
o.placeholder = 1081
o.default = 1081

o = s:option(Flag, "use_conf_file", translate("Use Config File"))
o.default = 1
o.rmempty = false

o = s:option(Flag, "write", translate("Auto_write"), translate("Write config to config.json files automatically."))
o.default = 0
o.rmempty = false

e = {
	"/etc/shadowsocks/config.json",
	"/etc/shadowsocks/a_config.json",
	"/etc/shadowsocks/b_config.json",
	"/etc/shadowsocks/c_config.json",
	"/etc/shadowsocks/d_config.json",
}

o = s:option(ListValue, "config_file", translate("Config File Path"))
o.default = "/etc/shadowsocks/config.json"
o.datatype = "file"
for i,v in ipairs(e) do
	o:value(v)
end
o:depends("use_conf_file", 1)

o = s:option(Value, "server", translate("Server Address"))
o.datatype = "host"

o = s:option(Value, "server_port", translate("Server Port"))
o.datatype = "port"

o = s:option(Value, "local_port", translate("Local Port"))
o.datatype = "port"
o.placeholder = 1080
o.default = 1080

o = s:option(Value, "password", translate("Password"))
o.password = true

o = s:option(Value, "timeout", translate("Connection Timeout"))
o.datatype = "uinteger"
o.placeholder = 60
o.default = 60

e = {
	"table",
	"rc4",
	"rc4-md5",
	"aes-128-cfb",
	"aes-192-cfb",
	"aes-256-cfb",
	"bf-cfb",
	"camellia-128-cfb",
	"camellia-192-cfb",
	"camellia-256-cfb",
	"cast5-cfb",
	"des-cfb",
	"idea-cfb",
	"rc2-cfb",
	"seed-cfb",
	"salsa20",
	"chacha20",
}

o = s:option(ListValue, "encrypt_method", translate("Encrypt Method"))
for i,v in ipairs(e) do
	o:value(v)
end


o = s:option(Value, "ignore_list", translate("Proxy Method"))
o:value("/dev/null", translate("Global Proxy"))
o:value("/etc/shadowsocks/ignore.list", translate("Ignore List"))
o.default = "/etc/shadowsocks/ignore.list"
o.rmempty = false

-- UDP Forward
s = m:section(TypedSection, "shadowsocks", translate("UDP Forward"))
s.anonymous = true

o = s:option(Flag, "tunnel_enable", translate("Enable"))
o.default = 1
o.rmempty = false

o = s:option(Value, "tunnel_port", translate("UDP Local Port"))
o.datatype = "port"
o.default = 5300
o.placeholder = 5300

o = s:option(Value, "tunnel_forward", translate("Forwarding Tunnel"))
o.default = "8.8.4.4:53"
o.placeholder = "8.8.4.4:53"

-- Access Control
s = m:section(TypedSection, "shadowsocks", translate("Access Control"))
s.anonymous = true

s:tab("lan_ac", translate("LAN"))

o = s:taboption("lan_ac", ListValue, "lan_ac_mode", translate("Access Control"))
o:value("0", translate("Disabled"))
o:value("1", translate("Allow listed only"))
o:value("2", translate("Allow all except listed"))
o.default = 0
o.rmempty = false

a = luci.sys.net.arptable() or {}

o = s:taboption("lan_ac", DynamicList, "lan_ac_ip", translate("LAN IP List"))
o.datatype = "ipaddr"
for i,v in ipairs(a) do
	o:value(v["IP address"])
end

s:tab("wan_ac", translate("WAN"))

o = s:taboption("wan_ac", DynamicList, "wan_bp_ip", translate("Bypassed IP"))
o.datatype = "ip4addr"

o = s:taboption("wan_ac", DynamicList, "wan_fw_ip", translate("Forwarded IP"))
o.datatype = "ip4addr"


s = m:section(TypedSection, "shadowsocks", translate("configure display and manual set"))
s.anonymous = true


editconf = s:option(TextValue, "config.json",
	translate("Show configuration of shadowsocks-libev-spec here."))
editconf.template = "cbi/tvalue"
editconf.size = 30
editconf.rows = 8
editconf.wrap = "off"

function editconf.cfgvalue(self, section)
	return fs.readfile ("/var/etc/shadowsocks.json") or ""
end


ignorelist = s:option(Value, "ignorelist", translate("Show or modify Ignore_list of shadowsocks-libev here."))
ignorelist.template = "cbi/tvalue"
ignorelist.size = 30
ignorelist.rows = 10
ignorelist.wrap = "off"

function ignorelist.cfgvalue(self, section)
	return fs.readfile("/etc/shadowsocks/ignore.list") or ""
end
function ignorelist.write(self, section, value)
	if value then
		value = value:gsub("\r\n?", "\n")
		fs.writefile("/etc/shadowsocks/ignore.list", value)
	end
end

return m
