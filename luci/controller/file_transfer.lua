--[[
Other module
Description: File upload / download, web camera
Author: yuleniwo  xzm2@qq.com  QQ:529698939
]]--

module("luci.controller.file_transfer", package.seeall)

function index()
	local page = entry({"admin", "system", "file_transfer"}, alias("admin", "system", "file_transfer", "updownload"), _("File_transfer"), 89)
	entry({"admin", "system", "file_transfer", "updownload"}, form("updownload"), _("Upload / Download"))
	page.i18n = "file_transfer"
	page.dependent = true
end
