Option Explicit

Dim strBit
Dim username
Dim ws
username = "jshuang"
Dim oldTime,usedTime,usedMins
Sub Main()

		oldTime = Timer  ' by second
		
		Dim strFunc	
		strFunc = crt.Dialog.Prompt (_ 
         "what is your make-command?", _ 
         "Send make-command to remote", _ 
         "" ) 
    If strFunc = "" Then Exit Sub    	
    	
		usedTime = Fix(Timer - oldTime)
		usedMins = Fix(usedTime/60)
    	
    strFunc = LCase(strFunc) 
    
    crt.Screen.Synchronous = True
    crt.Screen.Send strFunc & vbCr    'fetch remote information before gitk it
		crt.Screen.WaitForString username & "@"
		usedTime = Fix(Timer - oldTime)
		
		'sound prompt song
		set ws=createobject("wscript.shell")
		ws.run "wmplayer.exe E:\CRT_VBS\source\res\\promp_01.mp3",0 
		MsgBox "make is done." &vbCr&"used time(m:s) " & usedMins &":"&usedTime-usedMins*60
End Sub 

