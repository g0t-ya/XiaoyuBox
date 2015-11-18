module("luci.controller.nwan", package.seeall)

function index()

	if nixio.fs.access("/etc/config/nwan") then

	local page 	
	page = entry({"admin", "network", "nwan"}, cbi("nwan/nwan"), _("N-WAN"),47)
	page.i18n = "nwan"
	page.dependent = true
	end

	if nixio.fs.access("/etc/config/nwannumset") then
	local page 
	page = entry({"admin", "network", "nwannumset"}, cbi("nwan/nwannumset"), _("macvlan"), 46)
	page.i18n = "nwan"
	page.dependent = true
	end


end
