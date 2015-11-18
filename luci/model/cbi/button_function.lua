--[[
Other module
Description: button function setting
Author: rapistor 明月永在  QQ:273584038  群264838856  415192064
]]--


local fs = require "nixio.fs"
require("luci.tools.webadmin")

m = Map("button_function", translate("button_function","button_function"), translate("<p>查看帮助:<a target=\"_blank\" href=\"http://myop.ml/archives/category/firmware-guide/\">使用教程。</a>（作者：明月永在）</p>"))

s = m:section(TypedSection, "button_function", translate("config","config"), translate("Only support some routers,button a b c should be different if all enabled,mini should smaller than max."))
s.anonymous = true

enable = s:option(Flag, "button_enable", translate("Enable"), translate("Enable or Disable all button function."))
enable.default = false
enable.optional = false
enable.rmempty = false


a_enable = s:option(Flag, "a_enable", translate("enable_button_a"),translate("Enable or disable button A."))
a_enable.default = false
a_enable.optional = false
a_enable.rmempty = false

button_a = s:option(Value, "button_a", translate("button_a"),translate("Define button a."))
button_a:value("reset","reset")
button_a:value("wps","wps")
button_a:value("wifi","wifi")
button_a:value("usb","usb")
button_a.default = "reset"
button_a:depends("a_enable", "1")

reboot_enable = s:option(Flag, "reboot_enable", translate("reboot_enable"),translate("Enable or Disable reboot for button_a."))
reboot_enable.default = false
reboot_enable.optional = false
reboot_enable.rmempty = false
reboot_enable:depends("a_enable", "1")

a1 = s:option(Value, "a1", translate("wifi_switch_mini"))
a1:value("1", "1")
a1:value("2", "2")
a1:value("3", "3")
a1:value("4", "4")
a1:value("5", "5")
a1:value("6", "6")
a1:value("7", "7")
a1:value("8", "8")
a1:value("9", "9")
a1:value("10", "10")
a1.default = "1"
a1.widget = "select"
a1:depends("a_enable", "1")

a2 = s:option(Value, "a2", translate("wifi_switch_max"))
a2:value("1", "1")
a2:value("2", "2")
a2:value("3", "3")
a2:value("4", "4")
a2:value("5", "5")
a2:value("6", "6")
a2:value("7", "7")
a2:value("8", "8")
a2:value("9", "9")
a2:value("10", "10")
a2.default = "4"
a2.widget = "select"
a2:depends("a_enable", "1")

a3 = s:option(Value, "a3", translate("umount_disk_mini"))
a3:value("1", "1")
a3:value("2", "2")
a3:value("3", "3")
a3:value("4", "4")
a3:value("5", "5")
a3:value("6", "6")
a3:value("7", "7")
a3:value("8", "8")
a3:value("9", "9")
a3:value("10", "10")
a3.default = "4"
a3.widget = "select"
a3:depends("a_enable", "1")

a4 = s:option(Value, "a4", translate("umount_disk_max"))
a4:value("1", "1")
a4:value("2", "2")
a4:value("3", "3")
a4:value("4", "4")
a4:value("5", "5")
a4:value("6", "6")
a4:value("7", "7")
a4:value("8", "8")
a4:value("9", "9")
a4:value("10", "10")
a4.default = "9"
a4.widget = "select"
a4:depends("a_enable", "1")

a5 = s:option(Value, "a5", translate("reset_time"))
a5:value("1", "1")
a5:value("2", "2")
a5:value("3", "3")
a5:value("4", "4")
a5:value("5", "5")
a5:value("6", "6")
a5:value("7", "7")
a5:value("8", "8")
a5:value("9", "9")
a5:value("10", "10")
a5.default = "10"
a5.widget = "select"
a5:depends("a_enable", "1")


b_enable = s:option(Flag, "b_enable", translate("enable_button_b"),translate("Enable or disable button B."))
b_enable.default = false
b_enable.optional = false
b_enable.rmempty = false

button_b = s:option(Value, "button_b", translate("button_b"),translate("Define button b."))
button_b:value("reset","reset")
button_b:value("wps","wps")
button_b:value("wifi","wifi")
button_b:value("usb","usb")
button_b.default = "wps"
button_b:depends("b_enable", "1")

b2 = s:option(Value, "b2", translate("wifi_switch_time"))
b2:value("1", "1")
b2:value("2", "2")
b2:value("3", "3")
b2:value("4", "4")
b2:value("5", "5")
b2:value("6", "6")
b2:value("7", "7")
b2:value("8", "8")
b2:value("9", "9")
b2:value("10", "10")
b2.default = "2"
b2.widget = "select"
b2:depends("b_enable", "1")

b3 = s:option(Value, "b3", translate("umount_disk_mini"))
b3:value("1", "1")
b3:value("2", "2")
b3:value("3", "3")
b3:value("4", "4")
b3:value("5", "5")
b3:value("6", "6")
b3:value("7", "7")
b3:value("8", "8")
b3:value("9", "9")
b3:value("10", "10")
b3.default = "3"
b3.widget = "select"
b3:depends("b_enable", "1")

b4 = s:option(Value, "b4", translate("umount_disk_max"))
b4:value("1", "1")
b4:value("2", "2")
b4:value("3", "3")
b4:value("4", "4")
b4:value("5", "5")
b4:value("6", "6")
b4:value("7", "7")
b4:value("8", "8")
b4:value("9", "9")
b4:value("10", "10")
b4.default = "9"
b4.widget = "select"
b4:depends("b_enable", "1")

b5 = s:option(Value, "b5", translate("reset_time"))
b5:value("1", "1")
b5:value("2", "2")
b5:value("3", "3")
b5:value("4", "4")
b5:value("5", "5")
b5:value("6", "6")
b5:value("7", "7")
b5:value("8", "8")
b5:value("9", "9")
b5:value("10", "10")
b5.default = "10"
b5.widget = "select"
b5:depends("b_enable", "1")


c_enable = s:option(Flag, "c_enable", translate("enable_button_c"),translate("Enable or disable button C."))
c_enable.optional = false
c_enable.rmempty = false

button_c = s:option(Value, "button_c", translate("button_c"),translate("Define button c."))
button_c:value("reset","reset")
button_c:value("wps","wps")
button_c:value("wifi","wifi")
button_c:value("usb","usb")
button_c.default = "wifi"
button_c:depends("c_enable", "1")

c2 = s:option(Value, "c2", translate("wifi_switch_time"))
c2:value("1", "1")
c2:value("2", "2")
c2:value("3", "3")
c2:value("4", "4")
c2:value("5", "5")
c2:value("6", "6")
c2:value("7", "7")
c2:value("8", "8")
c2:value("9", "9")
c2:value("10", "10")
c2.default = "2"
c2.widget = "select"
c2:depends("c_enable", "1")

c3 = s:option(Value, "c3", translate("umount_disk_mini"))
c3:value("1", "1")
c3:value("2", "2")
c3:value("3", "3")
c3:value("4", "4")
c3:value("5", "5")
c3:value("6", "6")
c3:value("7", "7")
c3:value("8", "8")
c3:value("9", "9")
c3:value("10", "10")
c3.default = "3"
c3.widget = "select"
c3:depends("c_enable", "1")

c4 = s:option(Value, "c4", translate("umount_disk_max"))
c4:value("1", "1")
c4:value("2", "2")
c4:value("3", "3")
c4:value("4", "4")
c4:value("5", "5")
c4:value("6", "6")
c4:value("7", "7")
c4:value("8", "8")
c4:value("9", "9")
c4:value("10", "10")
c4.default = "9"
c4.widget = "select"
c4:depends("c_enable", "1")

c5 = s:option(Value, "c5", translate("reset_time"))
c5:value("1", "1")
c5:value("2", "2")
c5:value("3", "3")
c5:value("4", "4")
c5:value("5", "5")
c5:value("6", "6")
c5:value("7", "7")
c5:value("8", "8")
c5:value("9", "9")
c5:value("10", "10")
c5.default = "10"
c5.widget = "select"
c5:depends("c_enable", "1")


d_enable = s:option(Flag, "d_enable", translate("enable_button_d"),translate("Enable or disable button D."))
d_enable.optional = false
d_enable.rmempty = false

button_c = s:option(Value, "button_d", translate("button_d"),translate("Define button d."))
button_c:value("reset","reset")
button_c:value("wps","wps")
button_c:value("wifi","wifi")
button_c:value("usb","usb")
button_c.default = "usb"
button_c:depends("d_enable", "1")

d2 = s:option(Value, "d2", translate("wifi_switch_time"))
d2:value("1", "1")
d2:value("2", "2")
d2:value("3", "3")
d2:value("4", "4")
d2:value("5", "5")
d2:value("6", "6")
d2:value("7", "7")
d2:value("8", "8")
d2:value("9", "9")
d2:value("10", "10")
d2.default = "2"
d2.widget = "select"
d2:depends("d_enable", "1")

d3 = s:option(Value, "d3", translate("umount_disk_mini"))
d3:value("1", "1")
d3:value("2", "2")
d3:value("3", "3")
d3:value("4", "4")
d3:value("5", "5")
d3:value("6", "6")
d3:value("7", "7")
d3:value("8", "8")
d3:value("9", "9")
d3:value("10", "10")
d3.default = "3"
d3.widget = "select"
d3:depends("d_enable", "1")

d4 = s:option(Value, "d4", translate("umount_disk_max"))
d4:value("1", "1")
d4:value("2", "2")
d4:value("3", "3")
d4:value("4", "4")
d4:value("5", "5")
d4:value("6", "6")
d4:value("7", "7")
d4:value("8", "8")
d4:value("9", "9")
d4:value("10", "10")
d4.default = "9"
d4.widget = "select"
d4:depends("d_enable", "1")

d5 = s:option(Value, "d5", translate("reset_time"))
d5:value("1", "1")
d5:value("2", "2")
d5:value("3", "3")
d5:value("4", "4")
d5:value("5", "5")
d5:value("6", "6")
d5:value("7", "7")
d5:value("8", "8")
d5:value("9", "9")
d5:value("10", "10")
d5.default = "10"
d5.widget = "select"
d5:depends("d_enable", "1")

return m
