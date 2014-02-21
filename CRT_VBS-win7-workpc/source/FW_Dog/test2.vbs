Sub  Main ()    
     
    If Not  Continue("Do you wish to continue?", "Continue?") Then Exit Sub      
    
 
    If Not  Continue("The time is now: " & _ 
                     Time & _ 
                     ", do you wish to continue?" , _ 
                     "How about now?") Then Exit Sub  
     
    crt.Dialog.MessageBox "Reached the end of the script." 
End  Sub  
 
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Function  Continue(strMsg, strTitle) 
    ' Set the buttons as Yes and No, with the default button 
    ' to the second button ("No", in this example) 
    nButtons  = vbYesNo +  vbDefaultButton2  
     
    ' Set the icon of the dialog to be a question mark 
    nIcon  = vbQuestion  
     
    ' Display the dialog and set the return value of our 
    ' function accordingly 
    If crt.Dialog.MessageBox(strMsg, strTitle, nButtons + nIcon) <> vbYes  Then 
        Continue = False  
    Else 
        Continue = True 
    End  If 
End  Function 