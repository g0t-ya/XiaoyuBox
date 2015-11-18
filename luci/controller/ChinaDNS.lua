--[[
openwrt-dist-luci: ChinaDNS
]]--

module("luci.controller.ChinaDNS", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/chinadns") then
		return
	end

	entry({"admin", "services", "ChinaDNS"}, cbi("ChinaDNS"), _("ChinaDNS"), 52).dependent = true
end
