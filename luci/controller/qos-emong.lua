module("luci.controller.qos-emong", package.seeall)

function index()
	
	if not nixio.fs.access("/etc/config/qos-emong") then
		return
	end

	local page
	page = entry({"admin", "network", "qos-emong"}, cbi("qos-emong"), _("Emong QOS"), 58)
	page.i18n = "qos-emong"
	page.dependent = true
end
