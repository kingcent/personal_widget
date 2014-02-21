Dim username

Sub Main()
username = "jshuang"
TAG_NAME = "TAG_GS702A_4110_130702.xml"
Const STR_LEOPARD = "leopard"
Const STR_ANDROID = "android"
Const GIT_NAME_MAX_LEN = 20

Const BASE_PATH_ON_LINUX = "/media/"
Const DISK_LABEL_ON_WINXP = "M:/"

Const BASE_PATH_ON_LINUX_2 = "/home/local/ACTIONS/jshuang"
Const DISK_LABEL_ON_WINXP_2 = "N:"

Const BASE_PATH_ON_LINUX_3 = "/media2/"
Const DISK_LABEL_ON_WINXP_3 = "L:/"

Const REG_VALUE_LEN = 8

Set sh = CreateObject("WScript.Shell")

	strTag = crt.Dialog.Prompt (_ 
         "TAG you want to pick", _ 
         "", _ 
         "" ) 
  If strTag = "" Then Exit Sub
  If InStrRev(strTag, ".xml") = 0 Then strTag=strTag&".xml"
  TAG_NAME = strTag
  MsgBox "Name of TAG/BRANCH: " & TAG_NAME  	

crt.Screen.Synchronous = True
crt.Screen.Send chr(asc(UCase("C"))-64) & vbCr 'send Ctrl+C
crt.Screen.Send "pwd" & vbCr
crt.Screen.WaitForString "d" & vbCr ' do not use "pwd" to judge, because it is perhaps 'p\nwd'
strCurPath = crt.Screen.ReadString(username & "@") 
strCurPath = Mid(strCurPath, 2,Len(strCurPath)-3) 'do not include head/tail that is vbCr

'findout git repo name
loc = InStrRev(strCurPath,"/")
strGitName = Mid(strCurPath, loc+1, GIT_NAME_MAX_LEN)
MsgBox "Name of Git repo: " & strGitName

'findout .repo location
loc = InStr(1,strCurPath,STR_LEOPARD,1)
If loc<>0 Then
	strPojPath = Left(strCurPath, loc+Len(STR_LEOPARD))
Else
	loc = InStr(1,strCurPath,STR_ANDROID,1)
	strPojPath = Left(strCurPath, loc+Len(STR_ANDROID))
End If

'strWinPath = Replace(strPojPath,BASE_PATH_ON_LINUX,DISK_LABEL_ON_WINXP,1,1,1) & ".repo/manifests/"
strWinPath = Replace(strPojPath,BASE_PATH_ON_LINUX,DISK_LABEL_ON_WINXP,1,1,1)
strWinPath = Replace(strWinPath,BASE_PATH_ON_LINUX_2,DISK_LABEL_ON_WINXP_2,1,1,1)
strWinPath = Replace(strWinPath,BASE_PATH_ON_LINUX_3,DISK_LABEL_ON_WINXP_3,1,1,1)
strWinPath = strWinPath & ".repo/manifests/"


tagfile = strWinPath & TAG_NAME
MsgBox tagfile

commitId = ReadDataFromFile(CStr(tagfile),strGitName)
crt.Screen.Send  commitID & vbCr
MsgBox commitID
End Sub


Function ReadDataFromFile(strFile, gitName)	
	Set g_fso = CreateObject("Scripting.FileSystemObject")
'	MsgBox "tag file:" & strFile
'	MsgBox "git:" & gitName
	
	If Not g_fso.FileExists(CStr(strFile)) Then MsgBox "xml file not found":Exit Function
		
	Set objTextStream = g_fso.OpenTextFile(strFile, 1, False)
	Set re = New RegExp
	'\x22 is ascii code of ["], \x3d is for [=]
	re.Pattern = "revision\x3d\x22([\da-f]+)\x22"

	Do While Not objTextStream.AtEndOfStream
		strLine = Trim(objTextStream.ReadLine)
		MsgBox strLine
		If InStr(1,strLine,gitName,1)<>0 Then
			If re.Test(strLine)<>True Then
				MsgBox "no git repo found"
			Else  
				Set  matches = re.Execute(strLine)
				For  Each match In matches 
        	strSerial  = match.SubMatches(0) 
        	MsgBox "commit id: "  & strSerial 
    		Next 
			End  If
			Exit Do
		End If
	Loop
	objTextStream.Close
	ReadDataFromFile = strSerial
End Function