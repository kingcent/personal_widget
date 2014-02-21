Const ForWriting = 2
Const ForReading = 1
Const ForAppending = 8

DIR = WScript.Arguments(0)
'MsgBox DIR


Set sh = WScript.CreateObject("WScript.Shell")

'strHomeFolder = sh.ExpandEnvironmentStrings("%APPDATA%")
'MsgBox "cur_repo: " & strHomeFolder
'strHomeFolder = sh.ExpandEnvironmentStrings("%CUR_REPO%")
'MsgBox "CUR_REPO: " & strHomeFolder
'strHomeFolder = sh.ExpandEnvironmentStrings("%CUR_REPO_KC%")
'MsgBox "CUR_REPO_KC: " & strHomeFolder
'sh.Run("D:/sh --login -i cd_status_local " & DIR)
'sh.Run "D:/sh --login -i cd n:\702a_bf6\android\frameworks\base\ && gitk ",3,True
'ret = WScript.Run("D:/sh --login -i cd_status_local " & DIR, 1, True)

'Set wshShell = CreateObject("WScript.WshShell")
'Set WshEnv=sh.Environment("User")
'For Each v in WshEnv 
'	WScript.Echo(v)
'Next
'WshEnv.Item("CUR_REPO_KC") = DIR
'WScript.Echo WshEnv.Item("CUR_REPO_KC")

'sh.Run "E:/msysGit"
sh.Run "c:\msysgit\msysgit\bin\bash.exe --login -i"
'strResult = "E:\"
'sh.Run "D:/sh --login -i cdtest " &strResult

'MsgBox ret
