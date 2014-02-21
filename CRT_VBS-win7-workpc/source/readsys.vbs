Const REG_VALUE_LEN = 8

Set re = New RegExp
re.Pattern = "]:\s0x(\d+[a-f])\s"
'file = "0xb0158080"
file = "/sys/monitor/usb_port/config/detect_type"
crt.Screen.Synchronous = True
' Send a 'sh config' command to the Cisco PIX firewall.
crt.Screen.Send "cat " &file & vbCr
crt.Screen.WaitForString vbCr
strResult = crt.Screen.ReadString("root","shell") 
MsgBox strResult
Return

If re.Test(strResult)<>True Then
	MsgBox "not found"
Else
  
	Set  matches = re.Execute(strResult)
	For  Each match In matches 
        strSerial  = match.SubMatches(0) 
        MsgBox "reg data: "  & strSerial 
        strBit = base_convert(strSerial, 16, 2) 
        strBit = StrReverse(strBit)
        cnt = Len(strBit)
			  For i = 0 To 31
			  	If i<cnt Then
						MsgBox "reg " &i& " is:" & Mid(strBit, i+1, 1)
					Else
						MsgBox "reg " &i& " is:0"
					End If
			  Next
    Next 
End  If
'MsgBox strResult

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

