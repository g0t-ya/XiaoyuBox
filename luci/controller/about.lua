--[[
Other module
Description: button function setting
Author: Poseidon  QQ:11111111  群1111111  1111111
]]--

module("luci.controller.about", package.seeall)

function index()
        local page = entry({"admin", "about"}, alias("admin", "about"))
        entry({"admin", "about"}, form("about"), _("about"), 85)
        page.i18n = "about"
        page.dependent = true
end


