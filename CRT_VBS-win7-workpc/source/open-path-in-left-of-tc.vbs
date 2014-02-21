Dim username

Sub Main()
username = "jshuang"
TAG_NAME = "TAG_GS702A_4110_130702.xml"
Const STR_LEOPARD = "leopard"
Const STR_ANDROID = "android"
Const GIT_NAME_MAX_LEN = 20

Const PATH_NEED_TO_DEL = "/media/"
Const PATH_NEED_TO_DEL_2 = "/home/local/ACTIONS/jshuang/"
Const PATH_NEED_TO_DEL_3 = "/media2/"
Const REPLACE_PATH = ""


Set sh = CreateObject("WScript.Shell")

	
crt.Screen.Synchronous = True
crt.Screen.Send chr(asc(UCase("C"))-64) & vbCr 'send Ctrl+C
crt.Screen.Send "pwd" & vbCr
crt.Screen.WaitForString "d" & vbCr ' do not use "pwd" to judge, because it is perhaps 'p\nwd'
strCurPath = crt.Screen.ReadString(username & "@") 
strCurPath = Mid(strCurPath, 2,Len(strCurPath)-3) 'do not include head/tail that is vbCr.FUCKING THIS! I spent so much time on it.
'MsgBox "1 "&strCurPath
i = InStr(strCurPath, PATH_NEED_TO_DEL)
if (i<10) then
'	strCurPath = Replace(strCurPath,PATH_NEED_TO_DEL,REPLACE_PATH,1,1,1) 
	strCurPath = Replace(strCurPath,PATH_NEED_TO_DEL,"M:\",1,1,1) 
	disk="M:\"
end if
'MsgBox "2 "&strCurPath


strCurPath = Replace(strCurPath,PATH_NEED_TO_DEL_2,"N:\",1,1,1) 
disk="N:\"

strCurPath = Replace(strCurPath,PATH_NEED_TO_DEL_3,"L:\",1,1,1) 

'-------change / to \
strCurPath = Replace(strCurPath,"/","\") 
'MsgBox strCurPath
sh.Run "C:\totalcmd\TOTALCMD64.EXE /O /T /L="&strCurPath

End Sub