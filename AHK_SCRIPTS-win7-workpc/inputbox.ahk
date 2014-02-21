
DetectHiddenWindows, On  ;将托盘区的窗口也列进来
SetTitleMatchMode RegEx		;使用标题正则表达式匹配

;============================================================
;hotStrings
;============================================================
BAIDU_KEY=bd
GOOGLE_KEY=gg

#space::
	InputBox, UserInput, Phone Number, What do you want?, , , 
	if ErrorLevel
	{
	}
	else
	{
		StringSplit, ColorArray, UserInput, %A_Space%,
		if (ColorArray1="b" or ColorArray1="B")
		{
			StringReplace, OutputVar, UserInput, %ColorArray1%, ,
			Run, http://www.baidu.com/s?wd=%OutputVar%
			return
		}
		else if (ColorArray1="g" or ColorArray1="G")
		{
			StringReplace, OutputVar, UserInput, %ColorArray1%, ,
			Run, http://www.google.com.hk/search?q=%OutputVar%
			return
		}	
		else if (ColorArray1="fd")
		{
			Run, http://www.feidee.com/money/tally/new.do
			return
		}		
		else if (ColorArray1="wb")
		{
			Run,http://www.weibo.com/kingcenthuang?wvr=5&lf=reg
			return
		}
		else if (ColorArray1="at")
		{
			if (ColorArray2="cq")
			{
				Run,http://srv-cq/cqweb/main?command=GenerateMainFrame&rmsessionid=1acf0727-e511-4336-95e9-c0a801072004
				return
			}
			else if (ColorArray2="faq")
			{
				Run,http://cs.actions-semi.com/Faq.aspx
				return
			}
			else if (ColorArray2="wiki")
			{
				Run, http://192.168.40.15/mediawiki/index.php/Main_Page
				return
			}
			else if (ColorArray2="pm")
			{
				Run, C:\Program Files\SogouExplorer\SogouExplorer.exe http://pm.actions.com.cn/EPM/default.aspx
				return
			}
			else if (ColorArray2="dre")
			{
				IfWinNOTExist,Data Resource Explorer*
					run,C:\Program Files\TestDB Explorer\TestDB Explorer\Data Resource Explorer\Data Resource Explorer.exe
				else 
				{   
					IfWinActive,Data Resource Explorer*
					{
						WinMinimize   
					}
					else
					{
						WinActivate
					}
				}
				return 
			}
			
		}
	}
return

