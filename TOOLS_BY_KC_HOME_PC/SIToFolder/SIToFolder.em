macro GetCurrentProjectName()
{
	hprj = GetCurrentProj();
	curPrjPath = GetProjName(hprj);
	pathLen = strlen(curPrjPath);

	index = pathLen - 1;
	while (index >= 0) {
		if (curPrjPath[index] == "\\") {
			curPrjName = strmid(curPrjPath, index + 1, pathLen);
			break;
		}
		else {
			index = index - 1;
		}
	}

	return curPrjName;
}

// static
macro GetCurrentFileDir()
{
	buf = GetCurrentBuf();
	curFilePath = GetBufName(buf);
	pathLen = strlen(curFilePath);

	index = pathLen - 1;
	while (index >= 0) {
		if (curFilePath[index] == "\\") {
			curFileDir = strmid(curFilePath, 0, index);
			break;
		}
		else {
			index = index - 1;
		}
	}
	return curFileDir;
}

/**
 * Open the dir in the Project File Browser window,
 * which contains the current opened file.
 */
macro ToProjectFileBrowserFolder()
{
	RunCmd("Project File Browser");

	curPrjName = GetCurrentProjectName();
	curFileDir = GetCurrentFileDir();
	cmdLine = "D:\\SIToFolder.exe \"@curPrjName@ Project\"  \"@curFileDir@\"";

	RunCmdLine(cmdLine, Nil, 0);
}

/**
 * Open the dir in the explorer,
 * which contains the current opened file.
 */
macro ToExplorerFolder()
{
	curFileDir = GetCurrentFileDir();
	cmdLine = "explorer.exe \"@curFileDir@\"";
	RunCmdLine(cmdLine, Nil, 0);
}



macro PauseCurrentBugfea()
{
	SI_PRJ_BASE_DIR = "C:\\Documents and Settings\\Administrator\\My Documents\\Source Insight\\Projects\\";
	curPrjName = GetCurrentProjectName();
	bugfea_filename = cat(cat(SI_PRJ_BASE_DIR,curPrjName),"\\RELEATED_BUGFEA.txt");

	Msg(bugfea_filename);
	hbuf = OpenBuf(bugfea_filename);

	if(hbuf==hNil){
		msg("no such file");
		return;
	}
	
	lineCnt = GetBufLineCount(hbuf);
	i = 0;
	while(i<lineCnt) {
//		Msg(GetBufLine(hbuf, i));
		i = i+1;
	}
	CloseBuf(hbuf);

//	ShellExecute("open", "E:\software\TOOLS_BY_KC\TinyDevHelper\W_VBS\PauseCurrentBugfeaOnSI.vbs","","","");
//	ShellExecute("open", "notepad.exe");
	exec_vbs_file_name = "E:\\software\\TOOLS_BY_KC\\TinyDevHelper\\W_VBS\\switchBugfeaStateOnSI.vbs";
	cmdLine = cat("wscript.exe //e:vbscript ", exec_vbs_file_name);
	args = " @curPrjName@ WORKING_ON PAUSE";
	cmdLine = cat(cmdLine, args);
	RunCmdLine(cmdLine,Nil,0);
}

/*add the repo of this file to the current bugfea*/
macro AddRepo()
{
	/*current dir*/
	curFileDir = GetCurrentFileDir();
	curPrjName = GetCurrentProjectName();
	Msg(curFileDir)

	/*find out the repo's location 
	*add repo's location to bugfea's RELATED_SOURCE_REPO.txt .
	* strong recommand to show the result
	*/
	exec_vbs_file_name = "E:\\software\\TOOLS_BY_KC\\TinyDevHelper\\W_VBS\\addRepoToCurBugfea.vbs";
	cmdLine = cat("wscript.exe //e:vbscript ", exec_vbs_file_name);
	args = " @curPrjName@ @curFileDir@";
	cmdLine = cat(cmdLine, args);
	RunCmdLine(cmdLine,Nil,0);
	
}

macro WhatIsWorkingOn()
{
	SI_PRJ_BASE_DIR = "C:\\Documents and Settings\\Administrator\\My Documents\\Source Insight\\Projects\\";
	curPrjName = GetCurrentProjectName();
	bugfea_filename = cat(cat(SI_PRJ_BASE_DIR,curPrjName),"\\RELEATED_BUGFEA.txt");

	STR_CMP = "WORKING_ON";
	CMP_LEN = strlen(STR_CMP);

	hbuf = OpenBuf(bugfea_filename);
	lineCnt = GetBufLineCount(hbuf);
	i = 0;
	while(i<lineCnt){
		str = GetBufLine(hbuf,i);				
		i = i+1;
		
//		Msg(str);
		j = 0;
		while(j<CMP_LEN){
			if (str[j] ==STR_CMP[j]){
				j = j + 1;
			}else{
				j = 100; //break
			}
		}
		if (j==CMP_LEN){ //match STR_CMP
			i = 1000;//break
			Msg(str);
		}
	}
	CloseBuf(hbuf);
	
}