On Error Resume Next
Set objExplorer = CreateObject("InternetExplorer.Application", "IE_")
objExplorer.Navigate "file:///F:/password.htm"
objExplorer.ToolBar = 0
objExplorer.StatusBar = 0
objExplorer.Width = 400
objExplorer.Height = 350
objExplorer.Left = 300
objExplorer.Top = 200
objExplorer.Visible = True

Set  objShell  = CreateObject( "WScript.Shell" ) 
objShell.AppActivate objExplorer.document.Title 

'Do While (objExplorer.Document.Body.All.OKClicked.Value = "")
'Do While (objExplorer.Busy)
'		crt.Sleep 100
'Loop 

strPassword = objExplorer.Document.Body.All.UserPassword.Value
strButton = objExplorer.Document.Body.All.OKClicked.Value
'objExplorer.Quit
Wscript.Sleep 250
'If strButton = "Cancelled" Then Wscript.Quit
'Else Then        Wscript.Echo strPassword
'End If