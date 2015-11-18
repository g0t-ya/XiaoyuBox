
module("luci.controller.pppoe-relay", package.seeall)

function index()
	require("luci.i18n")
	luci.i18n.loadc("pppoe-relay")
	if not nixio.fs.access("/etc/config/pppoe-relay") then
		return
	end
	
	local page = entry({"admin", "services", "pppoe-relay"}, cbi("pppoe-relay"), luci.i18n.translate("pppoe-relay"), 37)
	page.i18n = "pppoe-relay"
	page.dependent = true
	
end
