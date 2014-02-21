Dim username

Sub Main()
username = "jshuang"
TAG_NAME = "TAG_GS702A_4110_130702.xml"
Const STR_LEOPARD = "leopard"
Const STR_ANDROID = "android"
Const GIT_NAME_MAX_LEN = 20

Const BASE_PATH_ON_LINUX = "/media"
Const DISK_LABEL_ON_WINXP = "M:"

Const REG_VALUE_LEN = 8

Set sh = CreateObject("WScript.Shell")

crt.Screen.Synchronous = True
crt.Screen.Send chr(asc(UCase("C"))-64) & vbCr 'send Ctrl+C
crt.Screen.Send "pwd" & vbCr
crt.Screen.WaitForString "pwd" & vbCr
strCurPath = crt.Screen.ReadString(username & "@") 


'MsgBox Replace(strCurPath,vbCr," ",1,-1,1)
strCurPath = Mid(strCurPath, 2,Len(strCurPath)-3)
'MsgBox Asc(strCurPath)
'MsgBox Len(strCurPath)

strWinPath = Replace(strCurPath,BASE_PATH_ON_LINUX,DISK_LABEL_ON_WINXP,1,1,1) '& ".repo/manifests/"
f = "M:/huangjinsheng/702a_0702_dusb/leopard/platform/drivers/usb/monitor"

MsgBox StrComp(strWinPath, f, 1)
'MsgBox Len(strCurPath)-Len(f)

'findout git repo name
loc = InStrRev(strCurPath,"/")
strGitName = Mid(strCurPath, loc+1, GIT_NAME_MAX_LEN)
'MsgBox strGitName

'findout .repo location
loc = InStr(1,strCurPath,STR_LEOPARD,1)
If loc<>0 Then
	strPojPath = Left(strCurPath, loc+Len(STR_LEOPARD))
Else
	loc = InStr(1,strCurPath,STR_ANDROID,1)
	strPojPath = Left(strCurPath, loc+Len(STR_ANDROID))
End If
MsgBox strPojPath




tagfile = strWinPath & TAG_NAME
tagfile = Trim(tagfile)

MsgBox tagfile & vbCr & "M:\huangjinsheng\702a_0702_dusb\leopard\.repo\manifests\TAG_GS702A_4110_130702.xml"
'MsgBox StrComp(CStr("M:\huangjinsheng\702a_0702_dusb\leopard\.repo\manifests\TAG_GS702A_4110_130702.xml"), CStr(tagfile), 0)
MsgBox StrComp(CStr("/media"), CStr(BASE_PATH_ON_LINUX), 0) 'equit

End Sub
