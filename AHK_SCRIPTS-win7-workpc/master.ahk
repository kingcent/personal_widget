; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

DetectHiddenWindows, On  ;���������Ĵ���Ҳ�н���
SetTitleMatchMode RegEx		;ʹ�ñ���������ʽƥ��

#z::Run www.autohotkey.com

#n::			;it means ctrl + alt +n
IfWinNOTExist, �ޱ��� - ����*
	run notepad
else    
	IfWinActive, �ޱ��� - ����*
		WinMinimize    
	else 
		WinActivate 
return 



;for pdf reader
;====================================
;#NoTrayIcon 
;#p::  
;	IfWinActive, ahk_class classFoxitReader  
		;WinMinimize, ahk_class classFoxitReader      
	;else 
;		WinActivate, ahk_class classFoxitReader   
;return 


#NoTrayIcon 
#p:: 
IfWinNOTExist, ahk_class CActionsProductToolMainUI
	run,C:\Program Files (x86)\Actions\PAD��������\1.06.01\MainApp.exe
else    
	IfWinActive, ahk_class CActionsProductToolMainUI       
		WinMinimize    
	else 
		WinActivate 
return 


#NoTrayIcon 
#v:: 
IfWinNOTExist, ahk_class Vim
		WinActivate
else    
	IfWinActive, ahk_class Vim     
		WinMinimize    
	else 
		WinActivate 
return 

;for total commander
;====================================
#NoTrayIcon 
#c:: 
IfWinNOTExist, Total Commander
	run,C:\totalcmd\TOTALCMD64.EXE
else    
	IfWinActive, Total Commander
		WinMinimize    
	else 
		WinActivate 
return 

;====================================
;for Foxmail
#NoTrayIcon 
#f:: 
IfWinNOTExist, Foxmail 
	run,D:\Program Files\Foxmail 7.1\Foxmail.exe
else    
	IfWinActive, Foxmail    
		WinMinimize    
	else 
		WinActivate 		
return 

;for ultraedit
;====================================
#NoTrayIcon 
#u:: 
IfWinNOTExist, UEStudio* 
	run,D:\software\UEStudio_V10.30.0.1000_Crack\UEStudio.exe
else    
	IfWinActive, UEStudio*    
		WinMinimize    
	else 
		WinActivate 		
return 

;for ultraedit
;====================================
#s:: 
IfWinNOTExist,ahk_class si_Frame
	run,D:\software\SourceInsight_ha\SourceInsight\Insight3_en.exe
else    
	IfWinActive,ahk_class si_Frame 
		WinMinimize    
	else 
		WinActivate 		
return 

;for firefox
;===================================
#NoTrayIcon 
#x::
IfWinNOTExist,ahk_class MozillaWindowClass
	run,C:\Program Files (x86)\Mozilla Firefox\firefox.exe
else    
	IfWinActive,ahk_class MozillaWindowClass
		WinMinimize, - Mozilla Firefox ahk_class MozillaWindowClass    
	else
	{
		WinShow, - Mozilla Firefox ahk_class MozillaWindowClass
		WinActivate, - Mozilla Firefox ahk_class MozillaWindowClass
	}
return 

;for wiz
;===================================
#NoTrayIcon 
#w::
IfWinNOTExist,ahk_class WizNoteMainFrame
	run,C:\Program Files\Wiz\Wiz.exe
else    
	IfWinActive,ahk_class WizNoteMainFrame
		WinMinimize    
	else
		WinActivate	
return 


;for todolist wunderlist
;===================================
#NoTrayIcon
#t::
IfWinNOTExist,ahk_class UserWindowWin
	run,C:\Program Files\Wunderlist\Wunderlist.exe
else    
	IfWinActive,ahk_class UserWindowWin
	{
		WinMinimize   
	}
	else
	{
		WinActivate
	}
return 



;for Serial-COM3 - SecureCRT
;===================================
#NoTrayIcon
#a::
IfWinNOTExist, ahk_class VanDyke Software - SecureCRT
	;run,D:\software\securecrt_password-less\securecrt\securecrt\SecureCRT.exe
	run, D:\software_company\SecureCRT_perfect\SecureCRT.exe
else    
	IfWinActive, ahk_class VanDyke Software - SecureCRT
	{
		WinMinimize   
	}
	else
	{
		WinActivate
	}
return 


;for vnc
;===================================
#NoTrayIcon
!^v::
IfWinNOTExist,ahk_class rfb::win32::DesktopWindowClass
{
	run,E:\Company\vnc\vnc\vnc-4_1_2-x86_win32_viewer.exe
	return
}
else    
	IfWinActive,ahk_class rfb::win32::DesktopWindowClass
	{
		WinMinimize   
		return
	}
	else
	{
		WinActivate,ahk_class rfb::win32::DesktopWindowClass
		return
	}
return 




;for everything
;===================================
#NoTrayIcon
;!F2::
IfWinNOTExist,ahk_class EVERYTHING
	run,C:\Program Files\Everything\Everything.exe
else    
	IfWinActive,ahk_class EVERYTHING
	{
		WinMinimize   
	}
	else
	{
		WinActivate
	}
return 

:*:]t::  ; This hotstring replaces "]t" with the current date and time via the commands below.
FormatTime, d,, WDay
DayArray:=Object()
DayArray[1]:="[��]"
DayArray[2]:="[һ]"
DayArray[3]:="[��]"
DayArray[4]:="[��]"
DayArray[5]:="[��]"
DayArray[6]:="[��]"
DayArray[7]:="[��]"
day:=DayArray[d]
FormatTime, CurrentDateTime,, Md-Hm
SendRaw %CurrentDateTime%
return

:*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
FormatTime, d,, WDay
DayArray:=Object()
DayArray[1]:="[��]"
DayArray[2]:="[һ]"
DayArray[3]:="[��]"
DayArray[4]:="[��]"
DayArray[5]:="[��]"
DayArray[6]:="[��]"
DayArray[7]:="[��]"
day:=DayArray[d]
FormatTime, CurrentDateTime,, yyyy/M/d%day%
SendRaw %CurrentDateTime%
return

:*:]-d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
FormatTime, d,, WDay
DayArray:=Object()
DayArray[1]:="[��]"
DayArray[2]:="[һ]"
DayArray[3]:="[��]"
DayArray[4]:="[��]"
DayArray[5]:="[��]"
DayArray[6]:="[��]"
DayArray[7]:="[��]"
day:=DayArray[d]
FormatTime, CurrentDateTime,, yyyy-M-d%day%
SendRaw %CurrentDateTime%
return

;for frequently used words for work
;=====================
:*:]w::
{
			words_num:=8
			item_selected:=1
			radio:=Object()

			Words:=Object()
			Words[1]:="hi ������������е����������ڹ���ʲôʱ�������ɣ��ͻ��ٴδ��ʣ��������ͣ����ز�ס�ˣ����æ��^_^"
			Words[2]:="dears, ���������Ҫ��չ�����`nthanks"
			Words[3]:="dears, ���������Ҫ��չ��`nthanks"
			Words[4]:="dears, ���������Ҫ�����ۡ�`nthanks"			
			Words[5]:="���Ե�[__����/��__]���н�չ����֪��ظ����ˣ�лл"
			Words[6]:="�õģ��˽⣬лл��"
			Words[7]:="[�õģ�XX��лл]�����������˽�һ�£�����ͬ��һ����Ϣ��\n1.\n2."
			Words[8]:="[]�����⣬������ϵͳ�ϱ���FAQ�ɣ�������෽�������������ⲻ��FAQ�����ö��֡���ϸ˵����������󼰲������衣лл"


			Loop, %words_num%
			{
				word:=Words[a_index]
    				Gui,Add,radio,gradio2 vradio%a_index%,%word%
    			}

    			
    			Gui, Add, Button, default xm, OK ; xm ��ʾ�Ѹÿؼ���ʾ�ڴ�������½�  
    			Gui,Show,w500  
    			return  
    			
radio2:       
    			return
      
ButtonOK: 
			{ 
	    			Gui, Submit ; ����ÿ����ؼ�������ı���  
	    			Loop,%words_num%
	    			{
	    				if(radio%a_index%=1)
	    				{
	    					item_selected:=a_index
	    					break
	    				}
	    			}
	    			word:=Words[item_selected]
	    			SendRaw %word%
	    			Gui,Destroy
	    			return
			}
      
;    			GuiClose:  
    			GuiEscape:  
    			{
				Gui,Destroy
				return
			}
		}
return




;============================================================
;hotStrings
;============================================================
::btw::by the way

::sjlh::
	run \\192.168.40.72
return

::hjsh::
	run \\192.168.40.139
return

;============================================================
;for other ahk scripts
;============================================================
GoSub InputBoxAhk
GoSub RunCommandAhk


InputBoxAhk:
#Include D:\AHK_SCRIPTS\inputbox.ahk

RunCommandAhk:
#Include D:\AHK_SCRIPTS\runcommand.ahk


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
