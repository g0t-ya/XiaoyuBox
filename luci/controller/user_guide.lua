--[[
Other module
Description: button function setting
Author: rapistor 明月永在  QQ:273584038  群264838856  415192064
]]--

module("luci.controller.user_guide", package.seeall)

function index()
        local page = entry({"admin", "user_guide"}, alias("admin", "user_guide"))
        entry({"admin", "user_guide"}, cbi("user_guide"), _("user_guide"), 15)
        page.i18n = "user_guide"
        page.dependent = true
end

