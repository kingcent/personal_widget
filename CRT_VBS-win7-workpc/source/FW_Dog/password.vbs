On Error Resume Next
Set Wscript = CreateObject("WScript.Shell")
Set objExplorer = WScript.CreateObject("InternetExplorer.Application", "IE_")
objExplorer.Navigate "file:///F:\password.htm"
objExplorer.ToolBar = 0
objExplorer.StatusBar = 0
objExplorer.Width = 400
objExplorer.Height = 350 
objExplorer.Left = 300
objExplorer.Top = 200
objExplorer.Visible = 1
Do While (objExplorer.Document.Body.All.OKClicked.Value = "")        
	Wscript.Sleep 250
Loop 
strPassword = objExplorer.Document.Body.All.UserPassword.Value
strButton = objExplorer.Document.Body.All.OKClicked.Value
objExplorer.Quit
Wscript.Sleep 250


'If strButton = "Cancelled" Then
'	Wscript.Quit
'	MsgBox "hello"
'Else Then
	'Wscript.Echo "strPassword"
'	MsgBox "strPassword"
'End If