Option Explicit

Dim strBit
Sub Main()
	
		Dim regViewFile,strPrompt
		regViewFile = "file:///e:/CRT_VBS/source/RegDes_"
		
		'--------------initialize register
		Dim regName(2)
		regName(0) = "USB3_P0_CTL"
		regName(1) = "USB2_0ECS"
		regName(2) = "USB2_1ECS"
		
		strPrompt = ""
		Dim i
		For i = 0 To 2		
			strPrompt = strPrompt & i &":" & vbtab & regName(i) &vbcrlf	
		Next 			
		
		Dim strFunc	
		strFunc = crt.Dialog.Prompt (_ 
         strPrompt, _ 
         "Registor Select", _ 
         "" ) 
    If strFunc = "" Then Exit Sub
    	
    strFunc = LCase(strFunc)    
    regViewFile = regViewFile &regName(CInt(strFunc)) &".html"
    'MsgBox "regViewFile:"&regViewFile
    select case strFunc
    	case "0"
    end select

		ReadRegData(strFunc)

'---------------------open gui begin--------------------------
' Get a reference to IE's Application object 
Dim g_objIE
Set  g_objIE = CreateObject( "InternetExplorer.Application" ) 
g_objIE.Offline = True 
g_objIE.navigate regViewFile  
 
' This loop is required to allow the IE object to finish loading... 
Do 
    crt.Sleep 100 
Loop While  g_objIE.Busy 

'g_objIE.Document.Body.innerHTML = strHTMLBody 

' Prevent the MenuBar, StatusBar, AddressBar, and Toolbar from 
' being displayed as part of the IE window 
g_objIE.MenuBar = False  
g_objIE.StatusBar  = False  
g_objIE.AddressBar = False  
g_objIE.Toolbar = False  
 
' Set the initial size of the IE window 
g_objIE.height  = 700
'g_objIE.width = 425 
 
' Set the title of the IE window 
g_objIE.document.Title  = "Reg Data Of " &regName(CInt(strFunc))
 
g_objIE.Visible = True 
 
' This loop is required to allow the IE window to fully display 
' before moving on 
Do 
    crt.Sleep 100 
Loop While  g_objIE.Busy 
 
' This code brings the IE window to the foreground (otherwise, the window 
' would appear, but it would likely be behind the SecureCRT window, not 
' easily visible to the user). 
Dim objShell
Set  objShell  = CreateObject( "WScript.Shell" ) 
objShell.AppActivate g_objIE.document.Title 
 
 Do 
    crt.Sleep 100 
Loop While  g_objIE.Busy 

'--------------open gui done-------------------
Dim vDoc, table,cnt,j
Set vDoc = g_objIE.Document
Set table = vDoc.All("datatable" )

'MsgBox table.rows.length
cnt = Len(strBit)
j = 0
'MsgBox strBit
For  i = table.rows.length-1 To 1 Step -1
	If j<cnt Then
		 table.rows(i).cells(1).innertext  = Mid(strBit, j+1, 1)
		 j = j + 1
	Else 
		 table.rows(i).cells(1).innertext = 0
	End If
Next  

End Sub

Sub ReadRegData(reg_no)
Const REG_VALUE_LEN = 8
Dim re
Set re = New RegExp
re.Pattern = "]:\s0x([\da-f]+)"



Dim regadd(2),reg_addr,strResult
regadd(0)="0xb0158080" 'USB3_P0_CTL  'USB3 port0 external control and status request register
regadd(1)="0xb0158090" 'USB2_0ECS   'USB2 port0 external control and status request register
regadd(2)="0xb0158094" 'USB2_1ECS   'USB2 port1 external control and status request register
reg_addr = regadd(CInt(reg_no))
crt.Screen.Synchronous = True
' Send a 'sh config' command to the Cisco PIX firewall.
crt.Screen.Send "echo " &reg_addr& " > /sys/kernel/debug/asoc/reg" & vbCr
' Wait for the CR to be echoed back to us so that what is
' read from the remote is only the output of the command
' we issued (rather than including the command issued along
' with the output).
'crt.Sleep 200
crt.Screen.WaitForString vbCr
strResult = crt.Screen.ReadString("root")

If re.Test(strResult)<>True Then
	MsgBox "not found"
Else
  Dim match, matches,strSerial, cnt
	Set  matches = re.Execute(strResult)
	For  Each match In matches 
        strSerial  = match.SubMatches(0) 
        'MsgBox "reg data: "  & strSerial 
        strBit = base_convert(strSerial, 16, 2) 
        'MsgBox "strBit:"&strBit
        strBit = StrReverse(strBit)   'if value is 0x24(100100),strBit is "001001", from low to high
        cnt = Len(strBit)
        Dim i
			  For i = 0 To 31
			  	If i<cnt Then
						'MsgBox "reg " &i& " is:" & Mid(strBit, i+1, 1)
					Else
						'MsgBox "reg " &i& " is:0"
					End If
			  Next
  Next 
End  If
'MsgBox strBit
End Sub

Function  base_convert(number, frombase, tobase) 
Dim digits, num, ptr, i, n, c
    digits = "0123456789abcdefghijklmnopqrstuvwxyz" 
    
    If   frombase < 2   Or   frombase > 36   Then 
        Err.Raise   vbObjectError   +   7575  ,,  "Invalid from base" 
    End If 
    
    If   tobase < 2   Or   tobase > 36   Then 
        Err.Raise   vbObjectError   +   7575  ,,  "Invalid to base" 
    End If 
    
    number = CStr(number)
    n = Len(number) 
    
    For i = 1 To n 
        c = Mid(number, i, 1) 
        
        If c >= "0" And c <= "9"   Then 
            c = c - "0" 
        ElseIf   c >= "A" And c <= "Z" Then 
            c = Asc(c) - Asc("A") + 10 
        ElseIf   c >= "a" And c <= "z" Then 
            c = Asc(c) - Asc("a") + 10 
        Else 
            c = frombase 
        End If 
        
        If   c < frombase   Then 
            num = num * frombase + c 
        End If 
    Next 
        
    Do 
        ptr = ptr & Mid(digits, (num Mod tobase + 1), 1) 
        num = num \ tobase 
    Loop While(num)
    
    base_convert = StrReverse(ptr) 
End Function 

