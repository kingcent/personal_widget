
SI_PRJ = WScript.Arguments(0)
SI_STATE_FROM = WScript.Arguments(1)
SI_STATE_TO = WScript.Arguments(2)
MsgBox SI_PRJ



SOURCEINSIGHT_PROJECTS_DIR = "C:\Documents and Settings\Administrator\My Documents\Source Insight\Projects\"
FileName = SOURCEINSIGHT_PROJECTS_DIR & SI_PRJ & "\RELEATED_BUGFEA.txt"
FileContents = GetFile(FileName)
dFileContents = replace(FileContents, SI_STATE_FROM, SI_STATE_TO, 1, -1, 1)
MsgBox dFileContents
 
If dFileContents <> FileContents Then  
	ret = WriteFile(FileName, dFileContents)
	Wscript.Echo "Replace done."  
	If Len(ReplaceWith) <> Len(Find) Then  
	'计算替换总数  
	Wscript.Echo _  
	( (Len(dFileContents) - Len(FileContents)) / (Len(ReplaceWith)-Len(Find)) ) & _  
	" replacements."  
	End If  
Else  
	Wscript.Echo "Searched string Not In the source file"  
End If  

'读取文件  
function GetFile(FileName)  
If FileName<>"" Then  
Dim FS, FileStream  
Set FS = CreateObject("Scripting.FileSystemObject")  
on error resume Next  
Set FileStream = FS.OpenTextFile(FileName)  
GetFile = FileStream.ReadAll  
End If  
End Function  

'写文件  
function WriteFile(FileName, Contents)  
Dim OutStream, FS  

'on error resume Next  
Set FS = CreateObject("Scripting.FileSystemObject")  
MsgBox(FileName)
Set OutStream = FS.OpenTextFile(FileName, 2)   'for writing
OutStream.Write Contents
WriteFile = True  
End Function