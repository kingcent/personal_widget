
Sub Main()

	strCmd = crt.Dialog.Prompt (_ 
         "your long command", _ 
         "", _ 
         "" ) 
  If strCmd = "" Then Exit Sub	

crt.Screen.Synchronous = True
crt.Screen.Send chr(asc(UCase("C"))-64) & vbCr 'send Ctrl+C
crt.Screen.Send strCmd & vbCr

End Sub