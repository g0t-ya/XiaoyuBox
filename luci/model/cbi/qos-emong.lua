require("luci.tools.webadmin")

m = Map("qos-emong", translate("Emong's Qos","Emong's Qos"), translate("Quene performance ,connlimit,and ip speed limit."))

s = m:section(NamedSection,"main", "qos-emong", translate("General Setting","General Setting"), translate("Here you can set Upload and download speed."))
s.anonymous = false
s.addremove = false

enable = s:option(Flag, "enable", translate("Enable"), translate(""))
enable.default = false
enable.optional = false
enable.rmempty = false

down = s:option(Value, "down", translate("Download speed (kbit/s)"))
down.rmempty = false

up = s:option(Value, "up", translate("Upload speed (kbit/s)"))
up.rmempty = false



s = m:section(TypedSection, "ip-limit", translate("Speed filter per Ip"), translate("E.g:192.168.1.20,192.168.1.128/25,do not use 192.168.1.2-192.168.1.30"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true
s.sortable = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.default = false
enable.optional = false
enable.rmempty = false

ip = s:option(Value, "ip", translate("Ip Address"))
ip.rmempty = true
luci.tools.webadmin.cbi_add_knownips(ip)

downc = s:option(Value, "downc", translate("Download Ceil"))
downc.default = "500"
downc.rmempty = true

downr = s:option(Value, "downr", translate("Download Rate"))
downr.default = "250"
downr.rmempty = true


upc = s:option(Value, "upc", translate("Upload Ceil"))
upc.default = "500"
upc.rmempty = true

upr = s:option(Value, "upr", translate("Upload Rate"))
upr.default = "250"
upr.rmempty = true



s = m:section(TypedSection, "connlmt", translate("connlmt"), translate("Just under testing!"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true
s.sortable = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.default = false
enable.optional = false
enable.rmempty = false

ip = s:option(Value, "ip", translate("Ip Address"))
ip.rmempty = true
luci.tools.webadmin.cbi_add_knownips(ip)

tcp = s:option(Value, "tcp", translate("Tcp Limit"))
tcp.default = "100"
tcp.rmempty = true

udp = s:option(Value, "udp", translate("Udp Limit"))
udp.default = "50"
udp.rmempty = true



s = m:section(TypedSection, "port_first", translate("Ports first"), translate("port under will not go to quene."))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true
s.sortable = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.default = false
enable.optional = false
enable.rmempty = false

proto = s:option(Value, "proto", translate("Protocol"))
proto:value("tcp", "tcp", translate("TCP"))
proto:value("udp", "udp", translate("UDP"))
proto.rmempty = true

port = s:option(Value, "port", translate("Ports"))
port.rmempty = true


return m

