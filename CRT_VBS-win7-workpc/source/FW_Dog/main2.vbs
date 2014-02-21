' Get a reference to IE's Application object 
Set  g_objIE = CreateObject( "InternetExplorer.Application" ) 
g_objIE.Offline = True 
g_objIE.navigate "file:///F:/t2.html"  
 
' This loop is required to allow the IE object to finish loading... 
Do 
    crt.Sleep 100 
Loop While  g_objIE.Busy 

'g_objIE.Document.Body.innerHTML = strHTMLBody 

' Prevent the MenuBar, StatusBar, AddressBar, and Toolbar from 
' being displayed as part of the IE window 
g_objIE.MenuBar = False  
'g_objIE.StatusBar  = False  
g_objIE.AddressBar = False  
g_objIE.Toolbar = False  
 
' Set the initial size of the IE window 
g_objIE.height  = 200 
g_objIE.width = 425 
 
' Set the title of the IE window 
g_objIE.document.Title  = "Authentication Credentials Prompt" 
 
g_objIE.Visible = True 
 
' This loop is required to allow the IE window to fully display 
' before moving on 
Do 
    crt.Sleep 100 
Loop While  g_objIE.Busy 
 
' This code brings the IE window to the foreground (otherwise, the window 
' would appear, but it would likely be behind the SecureCRT window, not 
' easily visible to the user). 
Set  objShell  = CreateObject( "WScript.Shell" ) 
objShell.AppActivate g_objIE.document.Title 
 
' Once the dialog is displayed and has been brought to the 
' foreground, set focus on the control of our choice... 
g_objIE.Document.All ("Password" ).Focus 

crt.Dialog.MessageBox "1"
 
Do 
    ' If the user closes the IE window by Alt+F4 or clicking on the 'X' 
    ' button, we'll detect that here, and exit the script if necessary. 
    On Error  Resume Next 
        Err.Clear 
        strNothing = g_objIE.Document.All("ButtonHandler" ).Value 
        if Err.Number <> 0 then exit do 
    On Error  Goto 0 
 
    ' Check to see which buttons have been clicked, and address each one 
    ' as it's clicked. 
    Select  Case g_objIE.Document.All ("ButtonHandler" ).Value 
         Case "Cancel"  
            ' The user clicked Cancel. Exit the loop 
            g_objIE.quit 
            Exit Do 
             
         Case "OK" 
         'crt.Dialog.MessageBox "4"
            ' The user clicked OK. Act on the information in the 
            ' Username and Password fields. 
            ' Capture data from each field in the dialog... 
            strUsername = g_objIE.Document.All("Username" ).Value 
            strPassword = g_objIE.Document.All("Password" ).Value 
            g_objIE.quit 
            ' Now that we have closed the IE dialog, we can act on our data. 
            ' For this example, we will just display the information entered 
            ' in a text box. 
            If crt.Dialog.MessageBox("Username provided: " & strUsername  & _ 
                                     vbcrlf & vbcrlf & _ 
                                     "Would you also like to display the " & _ 
                                     "password that was entered?" , _ 
                                     "Data Display", _ 
                                     vbYesNo)  <> vbYes  Then Exit Do 
             
            crt.Dialog.MessageBox "Here is the password that was entered:"  & _ 
                vbcrlf & vbtab  & _ 
                "Password: " & strPassword 
 '           Exit Do 
    End  Select  
 'crt.Dialog.MessageBox "5"
    ' Wait for user interaction with the dialog... 
    crt.Sleep 200 
Loop 