Const ForWriting = 2
Const ForReading = 1
Const ForAppending = 8

CUR_BUGFEA = WScript.Arguments(0)

Const SI_EXE_PATH = "D:\software\SourceInsight_ha\SourceInsight\Insight3_en.exe"

Dim EXISTED_JOBS_CNT
Dim EXISTED_JOBS() 'MAX_EXISTED_JOB_CNT = 50
BUG_FEA_COLLECTION_PATH = "E:\BUG_FEATURE_COLLECTION\"

Dim EXISTED_SIPRJS()
SOURCEINSIGHT_PROJECTS_DIR = "C:\Documents and Settings\jshuang\My Documents\Source Insight\Projects\"

Const FUNC_CNT = 6
Dim FUNCTIONS(6)

	
Set fso = CreateObject("Scripting.FileSystemObject")
Set bugfeaFolder = fso.GetFolder(BUG_FEA_COLLECTION_PATH)
Set bugfeaSubFolders = bugfeaFolder.SubFolders
'MsgBox(CUR_BUGFEA)
Set cur_bugfea_file = fso.CreateTextFile(CUR_BUGFEA, True)
	
Set siprjFolder = fso.GetFolder(SOURCEINSIGHT_PROJECTS_DIR)
Set siprjsSubFolder = siprjFolder.SubFolders

Dim choice, strPromp
Dim existedJobs
	
Dim job_cnt
existedJobs = getExistedJobList(job_cnt)
'MsgBox existedJobs
job = InputBoxList_Value("The existed and schduled jobs is below" , existedJobs , job_cnt, "Choice a existed job")
If job <> "" then
	MsgBox "you choice " & job	 
	cur_bugfea_file.WriteLine(job)
End If
cur_bugfea_file.Close

Function InputBoxList_Value(prompt, list, list_len, title)
	list_prompt = ""
	for i = 0 to list_len
		list_prompt = list_prompt & i & ". " & list(i) & vbcr
	next
	id = InputBox(prompt & vbcr & vbcr & list_prompt, title)
	InputBoxList_Value = list(id)
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
