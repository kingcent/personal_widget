Const ForWriting = 2
Const ForReading = 1
Const ForAppending = 8
Dim SIMILAR_FILES()
Dim RESERVE_GITREPO()

NAME_TYPE = WScript.Arguments(0)
NAME = WScript.Arguments(1)
CUR_DIR = WScript.Arguments(2)
temp_commitid_file_name = WScript.Arguments(3)

tag_full_name = ""

'temp_commitid_file_name = "E:\\TinyDevHelper_TEMP\\temp_commitid.txt"
'temp_commitid_file_name = "D:\software\TOOLS_BY_KC\TinyDevHelper\TinyDevHelper_TEMP\\temp_commitid.txt"

Set fso = CreateObject("Scripting.FileSystemObject")

Set temp_commitid = fso.CreateTextFile(temp_commitid_file_name, True)
'MsgBox "direct commit id?" & NAME_TYPE
gitdir = getGitDir(CUR_DIR)
If NAME_TYPE = 1 Then
		temp_commitid.WriteLine("base=" & NAME)		
		temp_commitid.WriteLine("basetag=")
Else		
		commitid = getCommitIDByTAG(gitdir,NAME)
		temp_commitid.WriteLine("base=" & commitid)
		temp_commitid.WriteLine("basetag=" & NAME)
		temp_commitid.WriteLine("tag_fullname=" & tag_full_name)
		
End If
gitdir = LCase(gitdir)
gitdir = Replace(gitdir, "n:", "/n")
gitdir = Replace(gitdir, "\", "/")
temp_commitid.WriteLine("git_dir=" & gitdir &"/")

loc = InStr(1,gitdir, "70",0)
loc = InStr(loc,gitdir,"/",0)-1
temp_commitid.WriteLine("prj_dir=" & Left(gitdir,loc) &"/")
'MsgBox gitdir
'MsgBox loc
temp_commitid.Close

Function getGitDir(CUR_DIR)
'-----find out git name-----
	is_found = 0
	curDir = CUR_DIR
	Do While (len(curDir)>5 And is_found<>1)
'		MsgBox curDir
		is_existed = fso.FolderExists(curDir & "\.git")
'		MsgBox("is_existed?" & is_existed)
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
'	MsgBox destDir
	getGitDir = destDir
End Function
		
Function getCommitIDByTAG(CUR_DIR,NAME)
	
	If(Len(CUR_DIR)=InStrRev(CUR_DIR,"\")) Then
		CUR_DIR = Left(CUR_DIR,len(CUR_DIR)-1) 'delete the rightest \
	End If
	git_name = Right(CUR_DIR,Len(CUR_DIR)-InStrRev(CUR_DIR,"\"))
'	MsgBox git_name

	
	'-----find .repo base name-----
	xml = NAME & ".xml"
	loc = InStr(CUR_DIR, "\leopard\")
	If loc>0 Then
		tag_base_dir = Left(CUR_DIR,loc-1) & "\leopard\.repo\manifests\"
	Else
		loc = InStr(CUR_DIR, "\android\")		
		tag_base_dir = Left(CUR_DIR,loc-1) & "\android\.repo\manifests\"
	End If
'	MsgBox tag_base_dir

	'-----process short name-------
	cnt = 0
	If NAME_TYPE=2 Then
		Set tag_folder_obj = fso.GetFolder(tag_base_dir)
		'MsgBox NAME
		For Each file In tag_folder_obj.Files
			If InStrRev(file.name,NAME)>0 Then
'				MsgBox file.name
				ReDim Preserve SIMILAR_FILES(cnt + 1)
				SIMILAR_FILES(cnt) = file.name
				cnt = cnt + 1
			End If
		Next
		If cnt>0 Then
				tag_file = InputBoxList_Value("The existed and schduled jobs is below" , SIMILAR_FILES , cnt, "Choice a existed job")
				If tag_file <> "" then
					MsgBox "you choice " & tag_file	 
					xml_file = tag_base_dir & tag_file
					tag_full_name = Replace(tag_file,".xml", "")
					'MsgBox "tag_fullname:" &¡¡tag_full_name
				End If
		Else
			MsgBox "no tag file for: " & NAME
		End If
	Else
		xml_file = tag_base_dir & NAME & xml
	End If	
	
	'-----get commit id-----
	commit_id = ReadDataFromFile(CStr(xml_file), git_name)
	MsgBox "git:" & vbTab&vbTab & git_name & vbcr &_
		 "commitid:" & vbTab& commit_id
	getCommitIDByTAG = commit_id
End Function





Function ReadDataFromFile(strFile, gitName)	
	Set g_fso = CreateObject("Scripting.FileSystemObject")
'	MsgBox "tag file:" & strFile
'	MsgBox "git:" & gitName
	
	If Not g_fso.FileExists(CStr(strFile)) Then Exit Function
		
	Set objTextStream = g_fso.OpenTextFile(strFile, 1, False)
	Set re = New RegExp
	'\x22 is ascii code of ["], \x3d is for [=]
	re.Pattern = "revision\x3d\x22([\da-f]+)\x22"

	cnt = 0
	Do While Not objTextStream.AtEndOfStream
		strLine = Trim(objTextStream.ReadLine)
'		MsgBox strLine
		If InStr(1,strLine,gitName,0)>0 Then
'			MsgBox strLine						
			ReDim Preserve RESERVE_GITREPO(cnt + 1)
			cnt = cnt + 1
			RESERVE_GITREPO(cnt) = strLine
		End If
	Loop
	If cnt > 1 Then
		gitrepo_line = InputBoxList_Value("choose gitrepo line",RESERVE_GITREPO,cnt,"")	
	ElseIf cnt = 1 Then
		gitrepo_line = RESERVE_GITREPO(1)
	End If
	
	Set  matches = re.Execute(gitrepo_line)
	For  Each match In matches 
     	strSerial  = match.SubMatches(0) 
 ' 		MsgBox "commit id: "  & strSerial 
	Next
	objTextStream.Close
	Set g_fso = nothing
	ReadDataFromFile = strSerial
End Function

Function InputBoxList_Value(prompt, list, list_len, title)
	list_prompt = ""
	for i = 0 to list_len
		list_prompt = list_prompt & i & ". " & list(i) & vbcr
	next
	MsgBox (prompt & vbcr & vbcr & list_prompt)
	id = InputBox(prompt & vbcr & vbcr & list_prompt, title)
	InputBoxList_Value = list(id)
End Function