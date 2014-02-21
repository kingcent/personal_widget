username = "jshuang"
'crt.Window.Caption = "test"
Set oldTab = crt.GetScriptTab()
'MsgBox "current tab's index:"&oldTab.Index
FOLDER_NAME_MAX_LEN = 30
tagCnt = crt.GetTabCount()

Const BASE_PATH_ON_LINUX = "/media/huangjinsheng/"
Const BASE_PATH_ON_LINUX_2 = "/home/local/ACTIONS/jshuang/"

'MsgBox tagCnt
'Set tab = crt.GetTab(1)
'tab.Caption = "hell0"
for nIndex = 2 to tagCnt
	Set curTab = crt.GetTab(nIndex)
	curTab.Activate()
	if curTab.Session.Connected = True then
		crt.Sleep 500
		curTab.Screen.Synchronous = True
		curTab.Screen.Send chr(asc(UCase("C"))-64) & vbCr 'send Ctrl+C
		curTab.Screen.Send "pwd" & vbCr
	'	crt.Sleep 1000
		curTab.Screen.WaitForString "d" & vbCr ' do not use "pwd" to judge, because it is perhaps 'p\nwd'
		strCurPath = curTab.Screen.ReadString(username & "@") 
'		strCurPath = Mid(strCurPath, 2,Len(strCurPath)-3) 'do not include head/tail that is vbCr
	end if
'	MsgBox strCurPath

	'findout folder name
	loc = InStrRev(strCurPath,"/")
	strFolderName = ""
	strFolderName = Mid(strCurPath, loc+1, FOLDER_NAME_MAX_LEN)
'	MsgBox strFolderName

	
	'findout project name
	strWinPath = Replace(strCurPath,BASE_PATH_ON_LINUX,"",1,1,1)
	strWinPath = Replace(strWinPath,BASE_PATH_ON_LINUX_2,"",1,1,1)
	'Msgbox strWinPath
	LTrim(strWinPath)
	i = InStr(1,strWinPath,"/")
	'MsgBox i
	projectName = Left(strWinPath,i-1) '-1 for "/" symbol follow at the last position
	projectName = Mid(projectName,2) 'there is a vbCr at the head
	'MsgBox  projectName
	
	curTab.Caption = nIndex&"# " & projectName &":"& strFolderName
Next

'newtab = crt.session.ConnectInTab("/ssh2 192.168.4.233")
oldTab.Activate()
'crt.window.caption = "rrrr"