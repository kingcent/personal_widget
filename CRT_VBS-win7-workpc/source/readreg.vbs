Sub Main()
Const REG_VALUE_LEN = 8
Set re = New RegExp
re.Pattern = "]:\s0x(\d+[a-f])\s"
'reg_addr = "0xb0158080"
reg_addr = "0xb0154024"
crt.Screen.Synchronous = True
' Send a 'sh config' command to the Cisco PIX firewall.
crt.Screen.Send "echo " &reg_addr& " > /sys/kernel/debug/asoc/reg " & vbCr
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

