Set ie = CreateObject("InternetExplorer.Application")
Set Wscript = CreateObject("WScript.Shell")
'ie.Navigate "http://bbs.iaixue.com/login.php"
ie.Navigate "file:///F:/t1.html"
crt.Sleep 100
ie.visible=true