Dim username

Sub Main()
username = "jshuang"
TAG_NAME = "TAG_GS702A_4110_130702.xml"
STR_LEOPARD = "leopard"
STR_ANDROID = "android"
GIT_NAME_MAX_LEN = 20

Const REG_VALUE_LEN = 8

Set sh = CreateObject("WScript.Shell")

tagfile = "TAG_GS702C_4110_130606.xml"

commitID = ReadDataFromFile(tagfile, "hdmi")
If commitID="" Then MsgBox "not found commit id":Exit Sub
MsgBox "commitID:" & commitID

commitID = ReadDataFromFile("TAG_GS702C_4110_130609.xml", "aotsdf_udc")
If commitID="" Then MsgBox "not found commit id":Exit Sub
MsgBox "commitID:" & commitID

End Sub

Function ReadDataFromFile(strFile, gitName)	
	Set g_fso = CreateObject("Scripting.FileSystemObject")
	
	If Not g_fso.FileExists(strFile) Then MsgBox "file not found":Exit Function
		
	Set objTextStream = g_fso.OpenTextFile(strFile, 1, False)
	Set re = New RegExp
	'\x22 is ascii code of ["], \x3d is for [=]
	re.Pattern = "revision\x3d\x22([\da-f]+)\x22"

	Do While Not objTextStream.AtEndOfStream
		strLine = Trim(objTextStream.ReadLine)
		'MsgBox strLine
		If InStr(1,strLine,gitName,1)<>0 Then
			If re.Test(strLine)<>True Then
				MsgBox "not found"
			Else  
				Set  matches = re.Execute(strLine)
				For  Each match In matches 
        	strSerial  = match.SubMatches(0) 
    '    	MsgBox "commit id: "  & strSerial 
    		Next 
			End  If
			Exit Do
		End If
	Loop
	objTextStream.Close
	ReadDataFromFile = strSerial
End Function