--[[
Other module
Description: button function setting
Author: rapistor 明月永在  QQ:273584038  群264838856  415192064
]]--

module("luci.controller.button_function", package.seeall)

function index()
	require("luci.i18n")
	luci.i18n.loadc("button_function")
	if not nixio.fs.access("/etc/config/button_function") then
		return
	end
	
	local page = entry({"admin", "system", "button_function"}, cbi("button_function"), luci.i18n.translate("button_function"), 78)
	page.i18n = "button_function"
	page.dependent = true
	
end
