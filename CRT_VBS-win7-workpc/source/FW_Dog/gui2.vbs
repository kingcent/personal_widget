' Get a reference to IE's Application object 
Set  g_objIE = CreateObject( "InternetExplorer.Application" ) 
g_objIE.Offline = True 
g_objIE.navigate "file:///F:/t1.html"  
 
' This loop is required to allow the IE object to finish loading... 
Do 
    crt.Sleep 100 
Loop While  g_objIE.Busy 
