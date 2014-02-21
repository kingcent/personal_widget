source insight的“跳转到文件夹”插件
简介：在source insight中，使用插件中的两个宏（macro），可以：
1.在si的项目文件浏览器（Project File Browser）中，跳转到当前打开文件所在的目录。
2.在资源管理器中，跳转到当前打开文件所在的目录。

安装：
首先，打开source insight的Base工程，选择菜单Project->Add and Remove Project Files…，将插件包中的SIToFolder.em添加到Base工程。
其次，将文件SIToFolder.exe拷贝到D盘下。
第三，选择菜单Options->Key Assignments…，将命令（command）Macro: ToProjectFileBrowserFolder的快捷键设置为Ctrl+T。
你也可以将Macro: ToProjectFileBrowserFolder命令添加到菜单中，然后通过菜单来使用该命令。
第四，点击你打开的文件，按下Ctrl+T，你会发现自动显示了项目文件浏览器（Project File Browser）窗口，并跳转到当前文件所在的目录。
第五，你可以使用同样的方式调用宏Macro: ToExplorerFolder，它的作用是在资源管理器中打开当前文件所在的目录。

其它：
关于该插件的其它说明参见以下地址：
http://blog.csdn.net/chenyufei1013/archive/2010/11/22/6028016.aspx