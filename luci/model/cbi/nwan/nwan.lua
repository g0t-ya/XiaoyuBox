--[[
LuCI - Lua Configuration Interface

]]--

local io	= require "io"
local os	= require "os"
local table	= require "table"
local nixio	= require "nixio"
local fs	= require "nixio.fs"
local uci	= require "luci.model.uci"
luci.util	= require "luci.util"
local sys	= require "luci.sys"


require("luci.tools.webadmin")

function iproute()
	local data = {}
	local k = {"ipmas","dev1", "dev2", "proto", "kernel", "scope", "link", "src", "ipadd"}
	local ps = luci.util.execi("ip route")

	if not ps then
		return
	else
		ps()
	end

	for line in ps do
		local row = {}

		local j = 1
		for value in line:gmatch("[^%s]+") do
			row[k[j]] = value
			j = j + 1
		end

		if row[k[1]] then

 
			-- this is a rather ugly workaround to cope with wrapped lines in
			-- the df output:
			--
			--	/dev/scsi/host0/bus0/target0/lun0/part3
			--		114382024  93566472  15005244  86% /mnt/usb
			--

			if not row[k[1]] then
				j = 1
				line = ps()
				for value in line:gmatch("[^%s]+") do
					row[k[j]] = value
					j = j + 1
				end
			end

			table.insert(data, row)
		end
	end

	return data
end

require("luci.tools.webadmin")
local sys = require "luci.sys"

m = Map("nwan", translate("N-WAN"), translate("N-WAN allows for the use of multiple uplinks for load balancing and failover."))

-- translate("nwan_route_desc","setting n-wan routes."))

local iproute = iproute()

v = m:section(Table, iproute, translate("ip route"), translate("<p>如需帮助:<a target=\"_blank\" href=\"http://myop.ml/archives/category/firmware-guide/\">请查看使用教程</a></p>"))
ipmas = v:option(DummyValue, "ipmas")
dev1 = v:option(DummyValue, "dev1")
dev2 = v:option(DummyValue, "dev2")
proto = v:option(DummyValue, "proto")
kernel = v:option(DummyValue, "kernel")
scope = v:option(DummyValue, "scope")
link = v:option(DummyValue, "link")
src = v:option(DummyValue, "src")
ipadd = v:option(DummyValue, "ipadd")


s = m:section(TypedSection, "settings", translate("nwan_route_settings"),
	translate("Non Concurrent dial_up should enable 'nwan_enable','nwan_ping_ck','force_all_wan_up', Concurrent dial depends on 'concurrent-dial' and 'nwan_ping_ck',you can config according to the guide."))
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("nwan_enable"),translate("N_WAN ON OR OFF"))
enable.optional = false
enable.rmempty = false

function enable.write(self, section, value)
	if value == "0" then
		os.execute("/etc/init.d/nwan disable")
		os.execute("chmod 000 /etc/hotplug.d/iface/09-route")
	else
		os.execute("/etc/init.d/nwan enable")
		os.execute("chmod 777 /etc/hotplug.d/iface/09-route")
	end
	Flag.write(self, section, value)
end

ping_ck = s:option(Flag, "ping_ck", translate("nwan_ping_ck"),translate("ON_LINE CHECK ON OR OFF"))
ping_ck.optional = false
ping_ck.rmempty = false

force_all_wan_up = s:option(Flag, "force_all_wan_up", translate("force_all_wan_up"),translate("force all wan dial-up."))
force_all_wan_up:depends("ping_ck", "1")
force_all_wan_up.optional = false
force_all_wan_up.rmempty = false

sleeptime = s:option(Value, "sleeptime", translate("nwan_sleeptime"),translate("PING WAIT TIME / SECOND"))
sleeptime:value("1", "1")
sleeptime:value("2", "2")
sleeptime:value("3", "3")
sleeptime:value("4", "4")
sleeptime:value("5", "5")
sleeptime.default = "2"
sleeptime.widget = "select"
sleeptime.optional = false
sleeptime.rmempty = false

timeout = s:option(Value, "timeout", translate("ping_timeout"),translate("PING timeout / SECOND"))
timeout:value("1", "1")
timeout:value("2", "2")
timeout:value("3", "3")
timeout:value("4", "4")
timeout:value("5", "5")
timeout.default = "2"
timeout.widget = "select"
timeout.optional = false
timeout.rmempty = true

testip = s:option(Value, "testip", translate("nwan_testip"),translate("INTETNET TEST IP"))
testip.size = 55
testip.maxlength = 55
testip.optional = false
testip.rmempty = false

testip = s:option(Value, "testip2", translate("nwan_testip2"),translate("INTETNET TEST IP2"))
testip.size = 55
testip.maxlength = 55
testip.optional = false
testip.rmempty = false

concurrent_dial = s:option(Flag, "concurrent_dial", translate("concurrent-dial"),translate("Force concurrent dial-up.Concurrent dial depends on 'nwan_ping_ck',you should enable it first."))
concurrent_dial.optional = false
concurrent_dial.rmempty = false

button_redial = s:option(Button, "_button", translate("Manual_redial"), translate("Manual redial when WAN down,enabled when concurrent dial is on."))
button_redial:depends("concurrent_dial", "1")
button_redial.inputtitle = translate("execute Manual_Redial")
button_redial.inputstyle = "apply"

function button_redial.write(self, section)
	os.execute('/lib/nwan/manual_dial start &')
	self.inputtitle = translate("execute Manual_Redial")
end

enable = s:option(Flag, "1mac", translate("use the same mac"),translate("use the same mac to dial--do not enable unless you know what your are doing."))
enable.default = false
enable.optional = false
enable.rmempty = false

number = s:option(Value, "number", translate("redial_times"),translate("times of syncpp redial."))
number:value("2", "2")
number:value("3", "3")
number:value("4", "4")
number:value("5", "5")
number:value("6", "6")
number.default = "5"
number.widget = "select"
number.optional = false
number.rmempty = true

n = s:option(Value, "n", translate("wan_number"),translate("pppoe wan number."))
n:value("2", "2")
n:value("3", "3")
n:value("4", "4")
n:value("5", "5")
n:value("6", "6")
n:value("7", "7")
n:value("8", "8")
n:value("9", "9")
n:value("10", "10")
n.default = "5"
n.widget = "select"
n.optional = false
n.rmempty = true

success = s:option(Value, "success", translate("Number of successful dial-up"),translate("number of successful syncpp dial-up."))
success:value("2", "2")
success:value("3", "3")
success:value("4", "4")
success:value("5", "5")
success:value("6", "6")
success:value("7", "7")
success.default = "5"
success.widget = "select"
success.optional = false
success.rmempty = true

wait = s:option(Value, "before_wait", translate("before_wait_time"),translate("The number of seconds to wait before dialing(Seconds)."))
wait:value("10", "10")
wait:value("15", "15")
wait:value("20", "20")
wait:value("25", "25")
wait:value("30", "30")
wait.default = "20"
wait.widget = "select"
wait.optional = false
wait.rmempty = true

sleep_time = s:option(Value, "after_wait", translate("after_wait_time"),translate("The number of seconds to wait after dialing(Seconds)."))
sleep_time:value("6", "6")
sleep_time:value("8", "8")
sleep_time:value("10", "10")
sleep_time:value("12", "12")
sleep_time:value("15", "15")
sleep_time.default = "12"
sleep_time.optional = true
sleep_time.rmempty = true

dl_route_table = s:option(Flag, "dl_route_table", translate("nwan_dl_route_table"),translate("AUTO DOWNLOAD ROUTE TABLE"))
dl_route_table.optional = false
dl_route_table.rmempty = false

debug = s:option(ListValue, "debug", translate("nwan_debug","DEBUG  LOG_RECORD"))
debug :value("1", translate("nwan_off","OFF"))
debug :value("5", translate("nwan_on","ON"))
debug.optional = false
debug.rmempty = false

enable = s:option(Flag, "add_check", translate("add_check"),translate("add_check use to monitor adding wan(s) and redial."))
enable.default = false
enable.optional = false
enable.rmempty = false

check_times = s:option(Value, "check_times", translate("check_times"),translate("Check times before starting redial."))
check_times:value("3", "3")
check_times:value("4", "4")
check_times:value("5", "5")
check_times:value("6", "6")
check_times:value("7", "7")
check_times:value("8", "8")
check_times.default = "6"
check_times.optional = true
check_times.rmempty = true

check_time = s:option(Value, "check_time", translate("check_time"),translate("The time wait for the next check."))
check_time:value("15", "15")
check_time:value("20", "20")
check_time:value("25", "25")
check_time:value("30", "30")
check_time:value("35", "35")
check_time:value("40", "40")
check_times.default = "30"
check_times.optional = true
check_times.rmempty = true


int = m:section(TypedSection, "interface", translate("nwan_interface","WAN Interfaces"))
int.template = "cbi/tblsection"
int.addremove = true

name = int:option(ListValue, "name", translate("nwan_isp_name","isp name"))
name:value("mobile", translate("nwan_isp_mobile","mobile"))
name:value("other", translate("nwan_isp_other","other"))
name:value("telecom", translate("nwan_isp_telecom","telecom"))
name:value("unicom", translate("nwan_isp_unicom","unicom"))
name.default = "telecom"
name.optional = false
name.rmempty = true
name.widget = "select"

route = int:option(ListValue, "route", translate("nwan_route_method","wan route method"))
route:value("intelligent_routes", translate("nwan_intelligent_routes","intelligent routes"))
route:value("balance", translate("nwan_balance","balance"))
route.default = "balance"
route.optional = false
route.rmempty = true
route.widget = "select"

weight = int:option(ListValue, "weight", translate("nwan_weight","Load Balancer weight"))
weight:value("10", "10")
weight:value("9", "9")
weight:value("8", "8")
weight:value("7", "7")
weight:value("6", "6")
weight:value("5", "5")
weight:value("4", "4")
weight:value("3", "3")
weight:value("2", "2")
weight:value("1", "1")
weight.default = "1"
weight.widget = "select"
weight.optional = false
weight.rmempty = true

s = m:section(TypedSection, "mwanfw", translate("nwan_mwanfw","N-WAN ASSIGN OUT Rules"),	
	translate("Configure rules for directing outbound traffic through specified WAN Uplinks."))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true
s.sortable  = true

enable = s:option(Flag, "enable", translate("enable", "enable"))
enable.default = false
enable.optional = false
enable.rmempty = false

src = s:option(Value, "src", translate("nwan_src","Source Address"))
src.rmempty = true
src.default = "all"
src:value("all", translate("all"))
luci.tools.webadmin.cbi_add_knownips(src)

dst = s:option(Value, "dst", translate("nwan_dst","Destination Address"))
dst.rmempty = true
dst:value("all", translate("all"))
dst.default = "all"
luci.tools.webadmin.cbi_add_knownips(dst)

proto = s:option(Value, "proto", translate("nwan_proto","Protocol"))
proto.rmempty = true
proto:value("all", translate("all"))
proto:value("tcp_udp", translate("tcp/udp"))
local pats = io.popen("cat /etc/protocols|awk {'print $1 '}|grep -v \"#\"|tail -n +2")
if pats then
	local l
	while true do
		l = pats:read("*l")
		if not l then break end

		if l then
			proto:value(l)
		end
	end
	pats:close()
end

ports = s:option(Value, "ports", translate("nwan_ports","Ports"))
ports:depends( "proto" , "tcp" )
ports:depends( "proto" , "udp" )
ports:depends( "proto" , "tcp_udp" )
ports:value("all", translate("all", translate("all")))
ports:value("80", "80")
ports:value("8000", "8000")
ports:value("443", "443")
ports.rmempty = true

wanrule = s:option(Value, "wanrule", translate("nwan_wanrule","WAN Uplink"))
luci.tools.webadmin.cbi_add_networks(wanrule)
wanrule:value("wan", translate("wan"))
wanrule.optional = false
wanrule.rmempty = true
wanrule.default = "wan"

return m
