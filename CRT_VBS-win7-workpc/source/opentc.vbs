Dim username
username = "jshuang"

Const REG_VALUE_LEN = 8
Const BASE_PATH_ON_LINUX = "media"
Const DISK_LABEL_ON_WINXP = ""

Set sh = CreateObject("WScript.Shell")

Set re = New RegExp
re.Pattern = "]:\s0x(\d+[a-f])\s"

crt.Screen.Synchronous = True

crt.Screen.Send "git fetch gl5202" & vbCr    'fetch remote information before gitk it
crt.Screen.WaitForString username & "@"

crt.Screen.Send chr(asc(UCase("C"))-64) & vbCr 'send Ctrl+C
crt.Screen.Send "pwd" & vbCr
crt.Screen.WaitForString "d" & vbCr  ' do not use "pwd" to judge, because it is perhaps 'p\nwd'
strResult = crt.Screen.ReadString(username & "@") 
'MsgBox strResult

strWinPath = Replace(strResult,BASE_PATH_ON_LINUX,DISK_LABEL_ON_WINXP,1,1,1)
sh.Run "D:/sh --login -i cdtest " &strWinPath

