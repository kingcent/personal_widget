Const ForWriting = 2
Const ForReading = 1
Const ForAppending = 8

Const SI_EXE_PATH = "D:\software\SourceInsight_ha\SourceInsight\Insight3_en.exe"

Dim EXISTED_JOBS_CNT
Dim EXISTED_JOBS() 'MAX_EXISTED_JOB_CNT = 50
BUG_FEA_COLLECTION_PATH = "E:\BUG_FEATURE_COLLECTION\"

Dim EXISTED_SIPRJS()
SOURCEINSIGHT_PROJECTS_DIR = "C:\Documents and Settings\jshuang\My Documents\Source Insight\Projects\"

Const FUNC_CNT = 6
Dim FUNCTIONS(6)

	
Set wsh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set bugfeaFolder = fso.GetFolder(BUG_FEA_COLLECTION_PATH)
Set bugfeaSubFolders = bugfeaFolder.SubFolders
	
Set siprjFolder = fso.GetFolder(SOURCEINSIGHT_PROJECTS_DIR)
Set siprjsSubFolder = siprjFolder.SubFolders

Sub Main()
Dim choice, strPromp
Dim existedJobs
	FUNCTIONS(0) = "start a feature-add job"
	FUNCTIONS(1) = "start a bugfix job"
	FUNCTIONS(2) = "add a new feature-add job"
	choice = InputBoxList_ID("", FUNCTIONS, FUNC_CNT,"What do you want?")
	
	If choice=0 then	
		'MsgBox choice
		Dim job_cnt
		existedJobs = getExistedJobList(job_cnt)
'		MsgBox existedJobs
  	job = InputBoxList_Value("The existed and schduled jobs is below" , existedJobs , job_cnt, "Choice a existed job")
		If job <> "" then
'			 MsgBox "you choice " & job
			 siPrjName = getSIProjectName(job)
'			 MsgBox "si project: " & siPrjName
			 ret = putJobWokOnSIProject(job, siPrjName)			 
		End If
	ElseIf (choice = 2) then
		new_job = InputBox("Your new job's name" , "Name your new job")
	  newJobFolder = fso.CreateFolder(BUG_FEA_COLLECTION_PATH & new_job)			 
	  fso.CreateFolder(BUG_FEA_COLLECTION_PATH & new_job & "\SOURCE_CTRL\")
		Set newJobFolder = fso.GetFolder(BUG_FEA_COLLECTION_PATH & new_job & "\SOURCE_CTRL\")
			 
		Dim prj_cnt
		lstExistedSIPrj = getExistedSiPrj(prj_cnt)
		siprj = InputBoxList_Value("Existed SI projects", lstExistedSIPrj, prj_cnt, "SI project related to ?")
			 
	  '---------write si project name to bugfea file--------------
		Set si_project_name_file = newJobFolder.CreateTextFile("SI_PROJECT_NAME.txt",True)
		si_project_name_file.WriteLine(siprj)
		si_project_name_file.Close
		
		'---------create RELATED_SOURCE_REPO  under bugfea--------------
		Set related_src_repo_file = newJobFolder.CreateTextFile("RELATED_SOURCE_REPO.txt",True)
		related_src_repo_file.Close
		
		'---------write bugfea name to si project file--------------
		related_bugfea_filename = SOURCEINSIGHT_PROJECTS_DIR & siprj & "\RELEATED_BUGFEA.txt"
		is_existed = fso.FileExists(related_bugfea_filename)
		If (is_existed=false) Then
			MsgBox "create file: " & related_bugfea_filename
			Set related_bugfea_file = fso.CreateTextFile(related_bugfea_filename,False)
		Else
			Set related_bugfea_file = fso.OpenTextFile(related_bugfea_filename, ForAppending)
		End If
		str = related_bugfea_file.WriteLine("PEND=" & new_job)
		related_bugfea_file.Close
		
	End If 
End Sub

Function getSIProjectName(job)
	Set f = fso.OpenTextFile(BUG_FEA_COLLECTION_PATH & job & "\SOURCE_CTRL\SI_PROJECT_NAME.txt",ForReading)
	getSIProjectName = f.ReadLine
End Function

Function putJobWokOnSIProject(job, siPrjName)
		bugfea_file = SOURCEINSIGHT_PROJECTS_DIR & siPrjName & "\RELEATED_BUGFEA.txt"
		working_on = getProperty(bugfea_file,"WORKING_ON")
		If (working_on = job) Then
		    MsgBox "it is already working on [" & job & "]" &vbcr&_
		     "After SI started, switch to project [" & siPrjName & "] manually"
		  	putJobWokOnSIProject = True
		    Set	ret = wsh.exec(SI_EXE_PATH)
		ElseIf(working_on <> "") Then
			want_pause = InputBox("sorry, si project [" & siPrjName  & "] is working on [" & working_on & "]" & vbcr & "Do you want to pause it?", "Sorry")
			If (want_pause=1 Or want_pause=y) Then
				saveCurrentBugfeaSrc()
				
				'-------schedule job-------------
				If (setProperty(bugfea_file,"WORKING_ON",job) = True) Then
		    	MsgBox "After SI started, switch to project [" & siPrjName & "] manually"
		  		putJobWokOnSIProject = True
		    	Set	ret = wsh.exec(SI_EXE_PATH)
		  	End If
			Else
				MsgBox("Please pause the [" & working_on &"] on SI Project[" & siPrjName &"] manually before switch to [" & job & "]")
				putJobWokOnSIProject = False				
			End If
		Else
		  If (setProperty(bugfea_file,"WORKING_ON",job) = True) Then
		    MsgBox "After SI started, switch to project [" & siPrjName & "] manually"
		  	putJobWokOnSIProject = True
		    Set	ret = wsh.exec(SI_EXE_PATH)
		  End If
		End If
End Function

Function setProperty(bugfea_file,property,job)
		Set f = fso.OpenTextFile(bugfea_file, ForAppending)
		f.WriteLine(property & "=" & job)
		f.Close
		setProperty = True
End Function

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

Function InputBoxList_ID(prompt, list, list_len, title)
	list_prompt = ""
	for i = 0 to list_len-1
		list_prompt = list_prompt & i & ". " & list(i) & vbcr
	next
	InputBoxList_ID = InputBox(prompt & vbcr & vbcr & list_prompt, title)
End Function

Function InputBoxList_Value(prompt, list, list_len, title)
	list_prompt = ""
	for i = 0 to list_len
		list_prompt = list_prompt & i & ". " & list(i) & vbcr
	next
	id = InputBox(prompt & vbcr & vbcr & list_prompt, title)
	InputBoxList_Value = list(id)
End Function

Function getExistedSiPrj(byref prj_cnt)
	
	cnt = 0
	for each subFolder in siprjsSubFolder
'		MsgBox "SI Project:" & vbcr & subFolder.Name
		'ignore jobs have DONE
		If InStrRev(subFolder.Name,"DONE")=0 Then
			ReDim Preserve EXISTED_SIPRJS(cnt+1) ' use Preserve to keep previous value
			EXISTED_SIPRJS(cnt) =  subFolder.Name		
			cnt = cnt + 1
		End If
	next
	
	prj_cnt = cnt		
	getExistedSiPrj = EXISTED_SIPRJS	
End Function


Function getExistedJobList(byref job_cnt)

	cnt = 0
	for each subFolder in bugfeaSubFolders
'		msgbox subFolder.Name
		'ignore jobs have DONE
		If InStrRev(subFolder.Name,"DONE")=0 Then
			ReDim Preserve EXISTED_JOBS(cnt+1) ' use Preserve to keep previous value
			EXISTED_JOBS(cnt) = SubFolder.Name		
			cnt = cnt + 1
		End If
	next
	
	job_cnt = cnt
	getExistedJobList = EXISTED_JOBS
End Function
