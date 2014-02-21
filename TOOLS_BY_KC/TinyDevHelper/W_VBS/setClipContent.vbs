
str = WScript.Arguments(0)
'Set sh = CreateObject("WScript.Shell")
'str = "test"
'sh.Run "cmd.exe /c echo " & str & " |clip",0,False
'MsgBox str

'---------method 1----------------
Dim Word
Set Word = CreateObject("Word.Application")
Word.Documents.Add
Word.Selection.Text = str
Word.Selection.Copy
Word.Quit False

'---------method 2---------------
'clipboardData.clearData
'clipboardData.setData "Text",str


'----------method 3------------
'Set objIE = CreateObject("InternetExplorer.Application")
'objIE.Navigate("about:blank")
'objIE.document.parentwindow.clipboardData.SetData "text", str
'objIE.Quit