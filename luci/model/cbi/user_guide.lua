--[[
Other module
Description: user_guide this firmware
Author: rapistor—明月永在  and huble
QQ:273584038  群264838856  415192064
]]--

require("luci.tools.webadmin")

m = Map("user_guide", translate("user_guide","user_guide"), translate("\
<font size=\"4\" color=\"red\"><center><strong>使用须知</strong></center></font>\
<br/>\
<font size=\"3\" color=\"red\"><center><b>前言</b></center></font>\
<br/>\
<p style=\"text-indent:2em;\">\
本固件基于OpenWrt Barrier Breaker 14.07 r44952，加上主流的一些软件，由明月永在修改整理并编译。本人固件免费发放使用，每个版本都经过认真的测试，但本人不对使用固件所造成的后果负任何责任。OpenWrt使用难度肯定比原厂的系统高，个人认为OpenWrt并不是每个人都适合的。OpenWrt是给会用的人用的，或者是给会学习的人用的，不是给普罗大众用的。如果认为OpenWrt系统太难，建议使用原厂系统。\
</p>\
<p><font size=\"3\" color=\"red\"><strong>使用注意事项：</strong></font></p>\
\
<p style=\"text-indent:2em;\">\
五一版系列固件系统默认密码为<font color=\"red\">root，</font>无线默认密码更新为我博客网址：<font color=\"red\">www.myop.ml</font>(为了你的系统安全，建议登录后修改<font color=\"red\">登录密码和无线密码</font>）。</p>\
\
<p style=\"text-indent:2em;\">\
OpenWrt系统和软件使用都需要有一定的基础和经验，本人没有义务对固件的使用进行使用培训和教育。先提示一些基本的常识，QOS软件只能开一个；多拨和QOS冲突；Shadowsocks和QOS冲突；多拨软件NWAN和PPPOE(并发)多拨只能开一个。</p>\
\
<p><font size=\"3\" color=\"red\"><strong>如果有问题请按以下程序来解决：</strong></font></p>\
\
<p style=\"text-indent:2em;\">\
1、浏览器打开<a target=\"_blank\" href=\"http://www.myop.ml/\">www.myop.ml</a>登录到本人的博客，此博客已经写了许多图文并茂教程，大部分问题都能在此解决。如果此网站有问题打不开时，请使用备份网站：<a target=\"_blank\" href=\"http://www.mingyueyongzai.ml/\">www.mingyueyongzai.ml。</a></p>\
\
<p style=\"text-indent:2em;\">\
2、到恩山论坛搜索相关的内容，查找相关的解决方式，恩山上有很多使用教程，你碰到问题，别人基本会碰到过。另可使用百度、谷歌来查找解决方法。</p>\
\
<p style=\"text-indent:2em;\">\
3、加固件QQ交流群，请教一下群友。现在有三个群，前两个基本已满，可加第三个。<font color=\"red\">群号264838856、415192064 、102925513。</font>建群是提供一个平台给大家交流经验，互相帮助的，这里没有客服，如果你想找客服，就不必要加了，会让你失望的。提问请适当用词，质问式的提问有没有理你，那就看你的运气了。另外如果你会了，请帮助下别人。互相帮助是我们群存在的意义 ！！本人时间不多，一般不会回答使用问题，但可以接受bug提交和已有软件的功能改进，一般不接受增加软件要求。另外OpenWrt官方的bug，本人没能力来解决。所以提交bug前，请查先确认一下，是本人固件的bug还是官方op的bug。</p>\
\
<p style=\"text-indent:2em;\">\
4、本人愿意和水平相当的朋友交流，请注意是交流，对于只会一直问我要这要那的不算交流。本人最不喜欢不认识的人，一加群就上来要东西。请不要这样，会让你失望的，也会让双方都尴尬。其实你要的东西基本网上都找得到的。</p>\
\
<p style=\"text-indent:2em;\">\
5、如果经过多种努力，仍然没有好的解决方法，可以给我留言。如果本人有空，可以帮忙一下。请不要认为有问必答，问东西的人比较多，有问必答不现实的哈。质问式的提问、教程上已经写了有的，一般会被忽略。另外有很多软件，是朋友帮测试的，我也不会用。会打鱼的不会做鱼很正常哈。</p>\
\
<br/>\
<div style=\"text-align:right;\"><font size=\"3\" color=\"red\"><strong>明月永在 （rapistor) </strong></font></div><br/>\
<div style=\"text-align:right;\"><font size=\"3\" color=\"red\"><strong>2015年5月 </strong></font></div><br/>\
<p><strong>\
<font size=\"3\">QQ群：</font><font size=\"3\" color=\"red\">264838856、415192064 、451457714</font><br/>\
<br/>\
<font size=\"3\">教程网址：<a target=\"_blank\" href=\"http://www.myop.ml/\">www.myop.ml</a></font><br/>\
<br/>\
<font size=\"3\">备用教程网址：<a target=\"_blank\" href=\"http://www.mingyueyongzai.ml/\">www.mingyueyongzai.ml</a></font><br/>\
<br/>\
<font size=\"3\">固件更新地址：<a target=\"_blank\" href=\"http://pan.baidu.com/s/1i3uYGeh/\">http://pan.baidu.com/s/1i3uYGeh</a></font></strong></p>"))

s = m:section(TypedSection, "settings", translate("config","config"), translate("Clicking the 'Move_page' button will not only move this page to the back of Menu,but also set the default home_page to 'status' after reboot."))
s.anonymous = true
s.addremove = false

moveback = s:option(Button, "_moveback", translate("Move_page"), translate("Move thise page back to the back of Menu."))
moveback.inputtitle = translate("Move_page")
moveback.inputstyle = "apply"

function moveback.write(self, section)
	os.execute("sed -i 's/15)/79)/g' /usr/lib/lua/luci/controller/user_guide.lua")
	self.inputtitle = translate("Move_page")
end

return m

