Sub Main()
		
		strPrompt = "G:" & vbtab & "grep ? * -r" &vbcrlf& _
								"[0-8]:" & vbtab & "echo ? > /proc/sys/kernel/printk" & vbcrlf& _
								"R:" & vbtab & "replace udc-?.ko" &vbcrlf& _
								"LS:" & vbtab & "logcat -s ?" &vbcrlf& _
								"RM:" & vbtab & "mount -o rw,remount /misc" &vbcrlf& _
								"RU:" & vbtab & "mount -o rw,remount / && busybox rx /usbmond.sh" &vbcrlf& _
								"RS:" & vbtab & "mount -o rw,remount /system" &vbcrlf_
								
		strFunc = crt.Dialog.Prompt (_ 
         strPrompt, _ 
         "Function Select", _ 
         "" ) 
    If strFunc = "" Then Exit Sub
    	
    strFunc = LCase(strFunc)
    
    select case strFunc
    	case "g","G"
    		strGrep = crt.Dialog.Prompt (_ 
         "Input the string you want to find", _ 
         "", _ 
         "" ) 
        If strGrep<>"" Then crt.Screen.Send "grep '" & strGrep & "' * -r" & vbcr 
      case "0","1","2","3","4","5","6","7","8"
         crt.Screen.Send "echo " &strFunc& " > /proc/sys/kernel/printk" & vbcr 
      case "R","r"
      		strUdcTag = crt.Dialog.Prompt (_ 
         "the postfix of udc ko", _ 
         "", _ 
         "" ) 
         strCpUdcKo = "mount -o rw,remount /misc" &vbcr& _
            "busybox cp /mnt/sdcard/udc-" & strUdcTag& _
             ".ko /misc/modules/udc.ko"&vbcr 
         crt.Screen.Send strCpUdcKo
      case "ru"
      crt.Screen.Send "mount -o rw,remount /" &vbcr& "busybox rx /usbmond.sh" &vbcr
      case "ls"
      		strLogcatTag=crt.Dialog.Prompt (_ 
         "logcat tag you want to catch", _ 
         "", _ 
         "" ) 
         crt.Screen.Send "logcat -s " &strLogcatTag& " &" &vbcrlf
                  
      case "rm"
      	 crt.Screen.Send "mount -o rw,remount /misc"&vbcr 
      case "rs"
      	 crt.Screen.Send "mount -o rw,remount /system"&vbcr 
    end select
    
    'send string out
   ' crt.Screen.Send "grep " & strFunc & " * -r" & vbcr 
    
    nButtons  = vbYesNo +  vbDefaultButton2  
     
    ' Set the icon of the dialog to be a question mark 
    nIcon  = vbQuestion  
     
    ' Display the dialog and set the return value of our 
    ' function accordingly 
   '  If crt.Dialog.MessageBox("grep " & strFunc & " * -r" & vbcr , "H", nButtons + nIcon) <> vbYes  Then 
 '       Continue = False  
 '   Else 
  '      Continue = True 
  '  End  If

End Sub