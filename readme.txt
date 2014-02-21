Deploying
===============
cp AutoHotkey.ahk $USER_DIR/Documents/	#win7 and (xp?)
if (win7 work)
	cp AHK_SCRIPTS-win7-workpc/*	D:/AHK_SCRIPTS/
	cp CRT_VBS-win7-workpc/*	E:/CRT_VBS/		#for make SecureCrt work
	ln -s C:\Program Files (x86)\Git\bin\sh.exe D:\sh	#crt cannot start msysgit.exe which path has space 
	cp TOOLS_BY_KC-win7-workpc/*	D:/software/TOOLS_BY_KC
elif(win7 laptop)
	cp AHK_SCRIPTS-win7-laptop/*	D:/AHK_SCRIPTS/
elif(home pc)
	cp TOOLS_BY_KC_HOME_PC/*	D:/software/TOOLS_BY_KC