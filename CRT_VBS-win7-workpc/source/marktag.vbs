Dim username
Dim tag_full_name

Sub Main()
username = "jshuang"
TAG_NAME = "TAG_GS702A_4110_130702.xml"
Const STR_LEOPARD = "leopard"
Const STR_ANDROID = "android"
Const GIT_NAME_MAX_LEN = 20

Const BASE_PATH_ON_LINUX = "/media/"
Const DISK_LABEL_ON_WINXP = "M:/"

Const BASE_PATH_ON_LINUX_2 = "/home/local/ACTIONS/jshuang"
Const DISK_LABEL_ON_WINXP_2 = "N:"

Const BASE_PATH_ON_LINUX_3 = "/media2/"
Const DISK_LABEL_ON_WINXP_3 = "L:/"

Const REG_VALUE_LEN = 8


Set sh = CreateObject("WScript.Shell")


crt.Screen.Synchronous = True
crt.Screen.Send chr(asc(UCase("C"))-64) & vbCr 'send Ctrl+C
crt.Screen.Send "pwd" & vbCr
crt.Screen.WaitForString "d" & vbCr ' do not use "pwd" to judge, because it is perhaps 'p\nwd'
strCurPath = crt.Screen.ReadString(username & "@") 
TAIL_LEN = 5 'it was 3, now 5 is ok, not know why
strCurPath = Mid(strCurPath, 2,Len(strCurPath)-TAIL_LEN) 'do not include head/tail that is vbCr '
'MsgBox "1 " & strCurPath

	base = crt.Dialog.Prompt (_ 
         "Which commit id(or tag/branch,start *s* for short tag)\nyou want to checkout?", _ 
         "", _ 
         "" ) 

If base="" Then Exit Sub

'get full xml filename
	If (Left(base,1) = "s") Then
		base = Mid(base, 3, Len(base))
		NAME_TYPE = 2 ' short tag name like:0808
		'MsgBox "0.2:"&base
  End If 
  
 strCurPath = Replace(strCurPath,BASE_PATH_ON_LINUX,DISK_LABEL_ON_WINXP,1,1,1)
 strCurPath = Replace(strCurPath,BASE_PATH_ON_LINUX_2,DISK_LABEL_ON_WINXP_2,1,1,1)
 strCurPath = Replace(strCurPath,BASE_PATH_ON_LINUX_3,DISK_LABEL_ON_WINXP_3,1,1,1)
 'MsgBox "2 " & strCurPath
  commit_id = getCommitIDByTAG(strCurPath, base, NAME_TYPE)
  MsgBox "commitid: " & commit_id & vbcr & "tag:"&tag_full_name
         
If tag_full_name<>"" and commit_id<>"" Then
	crt.Screen.Send  "git tag " & tag_full_name &" " & commit_id & vbCr
End If

End Sub


Function ReadDataFromFile(strFile, gitName)	
	Set g_fso = CreateObject("Scripting.FileSystemObject")
	'MsgBox "tag file:" & strFile & vbcr & "git:" & gitName
	
	If Not g_fso.FileExists(CStr(strFile)) Then MsgBox "xml file not found":Exit Function
		
	Set objTextStream = g_fso.OpenTextFile(strFile, 1, False)
	Set re = New RegExp
	'\x22 is ascii code of ["], \x3d is for [=]
	re.Pattern = "revision\x3d\x22([\da-f]+)\x22"

	Do While Not objTextStream.AtEndOfStream
		strLine = Trim(objTextStream.ReadLine)
'		MsgBox strLine
		If InStr(strLine,gitName)>0 Then
'			MsgBox strLine
			If re.Test(strLine)<>True Then
				MsgBox "no git repo found"
			Else  
				Set  matches = re.Execute(strLine)
				For  Each match In matches 
        	strSerial  = match.SubMatches(0) 
'        	MsgBox "commit id: "  & strSerial 
    		Next 
			End  If
			Exit Do
		End If
	Loop
	objTextStream.Close
	ReadDataFromFile = strSerial
End Function


Function getCommitIDByTAG(CUR_DIR,NAME, NAME_TYPE)
	
	If(Len(CUR_DIR)=InStrRev(CUR_DIR,"/")) Then
		CUR_DIR = Left(CUR_DIR,Len(CUR_DIR)-1) 'delete the rightest \
	End If
	git_name = Right(CUR_DIR,Len(CUR_DIR)-InStrRev(CUR_DIR,"/"))
	git_name = Trim(git_name)
	'MsgBox "gitrepo name:" & git_name

	
	'-----find .repo base name-----
	xml = NAME & ".xml"
	loc = InStr(CUR_DIR, "/leopard/")
'	MsgBox "CUR_DIR " & CUR_DIR
	If loc>0 Then
		tag_base_dir = Left(CUR_DIR,loc-1) & "/leopard/.repo/manifests/"
	Else
		loc = InStr(CUR_DIR, "/android/")		
'		MsgBox loc
		tag_base_dir = Left(CUR_DIR,loc-1) & "/android/.repo/manifests/"
	End If
'	MsgBox "5:"&tag_base_dir

	'-----process short name-------
	cnt = 0
'	MsgBox "7:"&NAME_TYPE
	If NAME_TYPE=2 Then
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set tag_folder_obj = fso.GetFolder(tag_base_dir)
'		MsgBox "6:"&NAME
		For Each file In tag_folder_obj.Files
			'MsgBox "8:"& file.name
			If InStrRev(file.name,NAME)>0 Then
'				MsgBox file.name
				ReDim Preserve SIMILAR_FILES(cnt + 1)
				SIMILAR_FILES(cnt) = file.name
				cnt = cnt + 1
			End If
		Next
		If cnt>0 Then
				tag_file = InputBoxList_Value("The similar tags is below" , SIMILAR_FILES , cnt, "Choice a existed job")
				If tag_file <> "" then
					MsgBox "you choice " & tag_file	 
					xml_file = tag_base_dir & tag_file
					tag_full_name = Replace(tag_file,".xml", "")
					'MsgBox "2 tag_fullname:"&tag_full_name
				End If
		Else
			MsgBox "no tag file for: " & NAME
		End If
	Else
		xml_file = tag_base_dir & NAME & xml
	End If	
	
	'-----get commit id-----
	If xml_file <> "" Then
		commit_id = ReadDataFromFile(CStr(xml_file), git_name)
	End If
	getCommitIDByTAG = commit_id
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