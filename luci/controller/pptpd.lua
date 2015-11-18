--[[
LuCI - Lua Configuration Interface

]]--

module("luci.controller.pptpd", package.seeall)

function index()

	entry({"admin", "services", "pptpd"},
		alias("admin", "services", "pptpd", "pptpd"),
		_("PPTP VPN Server"), 38)
	entry({"admin", "services", "pptpd", "pptpd"},
		cbi("pptpd/pptpd"),
		_("General Settings"), 10).leaf = true
	entry({"admin", "services", "pptpd", "online"},
		cbi("pptpd/online"),
		_("Online Users"), 20).leaf = true

end
