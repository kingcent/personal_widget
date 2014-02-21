Const ForWriting = 2
Const ForReading = 1
Const ForAppending = 8

SOURCEINSIGHT_PROJECTS_DIR = "C:\Documents and Settings\jshuang\My Documents\Source Insight\Projects\"

SI_PRJ = WScript.Arguments(0)
DIR = WScript.Arguments(1)
'MsgBox DIR


BUG_FEA_COLLECTION_PATH = "E:\BUG_FEATURE_COLLECTION\"


Set fso = WScript.CreateObject("Scripting.FileSystemObject")


is_found = 0
curDir = DIR

Do While (len(curDir)>5 And is_found<>1)
	is_existed = fso.FolderExists(curDir & "\.git")
	If(is_existed = True) Then
		destDir = curDir
		is_found = 1
	End If
	curDir = Left(curDir,len(curDir)-1) 'delete the rightest \
	loc = InStrRev(curDir,"\")
'	MsgBox loc
	curDir = Left(curDir,loc)
'	MsgBox "after cut:" & curDir
Loop

If is_found=0 Then
	MsgBox "Damn, there is no repo for this file"
Else
	'-------add curDir to RELATED_SOURCE_REPO.txt--------
	MsgBox "repo loc:" & destDir
	
	bugfea_file = SOURCEINSIGHT_PROJECTS_DIR & SI_PRJ & "\RELEATED_BUGFEA.txt"
	MsgBox bugfea_file
	working_on = getProperty(bugfea_file,"WORKING_ON")
	If (working_on = "") Then
		MsgBox "nothing is working on"
	Else
		
		filename = BUG_FEA_COLLECTION_PATH & working_on & "\SOURCE_CTRL\RELATED_SOURCE_REPO.txt"
		MsgBox "RELATED_SOURCE_REPO: " & filename
		is_existed = FindContents(filename, destDir)
		If(is_existed=0) Then
			Set f = fso.OpenTextFile(filename,ForAppending)	
			f.WriteLine(destDir)
			f.Close
		Else
			MsgBox "it is related before"
		End If
		
  End If
End If

Function getProperty(bugfea_file,property)
		Set f = fso.OpenTextFile(bugfea_file, ForReading)
		is_found = 0
		Do While (Not f.AtEndOfStream And is_found<>1)
			str = f.ReadLine
			loc = InStr(str, property)
			If (loc > 0) Then
				'MsgBox "damn, it is working"
				getProperty = Mid(str, len(property)+2, len(str))
				is_found = 1
			End If
		Loop
		If (is_found = 0 ) Then
			getProperty = ""
		End If
		f.Close
End Function
	
Function FindContents(filename, destDir)
	Set f = fso.OpenTextFile(filename,ForReading)	
	is_found = 0
	Do While (Not f.AtEndOfStream And is_found = 0)
		If (InStr(f.ReadLine,destDir)>0) Then
			is_found = 1
		End If
	Loop
	FindContents = is_found
End Function

'Set bugfeaFolder = fso.GetFolder(BUG_FEA_COLLECTION_PATH)
'Set bugfeaSubFolders = bugfeaFolder.SubFolders