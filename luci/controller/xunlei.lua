
module("luci.controller.xunlei", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/xunlei") then
		return
	end

	local page
	page = entry({"admin", "usb_apps", "xunlei"}, cbi("xunlei"), _("迅雷远程下载"), 74)
	page.i18n = "xunlei"
	page.dependent = true
end
