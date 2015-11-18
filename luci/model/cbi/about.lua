--[[
Other module
Description: about this firmware
Author: rapistor—明月永在  and huble
QQ:273584038  群264838856  415192064
]]--


local fs = require "nixio.fs"

m = Map("about", translate("about","about"), translate("\
<font size=\"4\" color=\"red\"><center><strong>关于本固件</strong></center></font>\
<br/>\
<p style=\"text-indent:2em;\">此固件基于openwrt开源路由系统OpenWrt Barrier Breaker 14.07版本修改编译。迅雷界面来自Haxc，FTP软件来自hackpascal，redsocks2来自恩山论坛，界面是蝈蝈的。其它软件的界面主要来自openwrt.org.cn，大部分软件和界面都经过修改。</p>\
<p style=\"text-indent:2em;\">在折腾openwrt这一路上，我要感谢在技术上给我帮助的朋友，感谢帮忙测试固件的朋友。非常感谢群友hackpascal huble(brandnewman) 蝈蝈 haxc等大神，\
非常感谢其他朋友不厌其烦的测试固件。</p>\
<p style=\"text-indent:2em;\">特别感谢huble的大力支持，一个很有潜力年轻人，在折腾的过程中，提供了不少的关键支持。</p>\
<p style=\"text-indent:2em;\">本人从2013年末开始折腾openwrt，至今已近两年了。由于水平比较菜，基本上是现学现用的，因此一个软件的修改是——先修改，再编译，再在路由上修改，再编译，这样反反复复的调试。如今，总算摸着op的门槛了，很多群友都称我“大神”，我真的自感汗颜，我自认为是大白菜哈。</p>\
<p style=\"text-indent:2em;\">说下我为什么会编译固件，刚接触的时候，我加入一个“JS”群，(群里有几个大大是做淘宝的)。可能是因为我水平太菜，\
非常客气的向他们请教些问题，但基本没有人理我。因此，我发誓要打破“JS”们的技术垄断，做出不比他们差的固件来，（其实现在我也能理解，提问的人太多了，很难一一解答。）一方面为openwrt爱好者做些实事，一方面也证明给他们看，没有“JS”们，我照样能弄好。</p>\
<p style=\"text-indent:2em;\">这路上，真的挺不容易的，一个字，累。两千多小时在折腾openwrt，平时每天七八个小时，休息时是近二十多小时，常常一个问题反反复复得刷机无数次，晚上最晚的五点，基本两三点，一边到处搜索查找资料，一边反复刷机调试。太菜了，没办法，只能折腾。不过问题弄好了，还是很高兴的。</p>\
<p style=\"text-indent:2em;\">本以为编译固件不难，弄个版本就行了，结果bug不断的发现，只有硬着头皮，继续折腾。我是个有责任心的人，既然答应过给大家一个较完善的固件，就会努力，所以一直坚持到现在。不是诉苦，感慨一下而以，呵呵。</p>\
<p style=\"text-indent:2em;\">固件发布后，感触也挺多的，因为用的朋友多了，有新手有老手，都会有些问题不懂，然后来问我，这都能理解。可是，我也要工作，\
空闲的时间不多，要折腾固件，要修改软件，还要学习下脚本，和C语言相关的东西，以便更好的折腾固件。最近建立了交流群，基本一打开qq，会跳出好几个窗口来提问。对于客气的，我尽力来回复。对于质问的，我基本忽略。有好些把我当客服，加群就是来问的，不满意就直接退群，这类人，来去自由哈。建议大家在群里多交流，\
自己会了，也帮助下别人，我一个人真的忙不过来。</p>\
<p style=\"text-indent:2em;\">固件本来就是免费的，我为这些固件已经奉献出很多时间了，没有时间再来为各位一一解答了。现在我已经有了博客，基本知识和常用的使用教程我都写了，大家可以自己看看，请各位能理解哈。如果有bug还是欢迎各位反馈。各种驱动问题，比如无线信号不强，不能调大功率，无线容易中断等，这些不属于bug范围，至少我是解决不了的哈，要报也得向openwrt官方报告。还有软件的选择，已经综合考虑了大家的需要，不会为某一个人来改变，再说闪存的容量毕竟有限，装不了多少东西。<font color=\"red\"><strong>有特殊要求的可以付费定制哈。</strong></font></p>\
<p style=\"text-indent:2em;\">很多朋友认为openwrt是开源的，没有理由收费，但红帽的服务器系统也是得付费。个人认为开源源码和软件是不能用来卖钱，我也一直坚持这个原则。\
但原来的源码并不是拿来就能用的，开源代码各种bug需要修改，编译也不是打个包那么简单，修改和测试得花时间和精力，所以才增加了捐助方式，<font color=\"red\"><strong>如果你觉得本人的固件还不错，就请你捐助下哈。</strong>捐助的朋友，请在支付宝留言里写个路由型号，以便我对使用较多的型号进行优化。</font>\
在此，感谢捐助的朋友们！！</p>\
<p style=\"text-indent:2em;\">不好意思，啰嗦了这么多。这是<a target=\"_blank\" href=\"http://myop.ml\">我的博客</a>，上面有许多教程，请各位看看。<font color=\"red\"><strong>还有上面加了点小广告，以挣点服务器的费用，请大家帮点点，并在广告页面停留一下，以避免被认为作弊。也请不要多点，一个IP一天只能点一次。先谢了哈！！</strong></font></p><br/>\
<div style=\"text-align:right;\"><font size=\"3\" color=\"red\"><strong>明月永在 （rapistor) </strong></font></div><br/>\
<br/>\
<p><strong>\
版本：Barrier Breaker 14.07 <br/>\
使用前请阅读:<a target=\"_blank\" href=\"http://myop.ml/archives/category/firmware-guide\">固件使用教程</a><br/>\
更多信息请访问我的博客：<a target=\"_blank\" href=\"http://myop.ml/\"> www.myop.ml</a><br/>\
备用网址请访问备用博客：<a target=\"_blank\" href=\"http://mingyueyongzai.ml/\">www.mingyueyongzai.ml</a><br/>\
邮箱地址：<font color=\"red\">jianyueyong@gmail.com、jianyueyong@163.com</font><br/>\
另有问题请加群交流：<font color=\"red\">264838856、415192064、451457714</font> <br/>\
特别声明：<font color=\"red\">本固件只授权个人免费使用。另请不要使用固件从事违法活动，本人对软件不当使用所造成的后果不负任何责任。</font></strong></p><br/>"))
return m

