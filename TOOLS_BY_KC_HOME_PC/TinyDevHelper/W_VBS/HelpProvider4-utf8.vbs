Function PathRemoveFileSpec1(strFileName)
  strFileName = Replace(strFileName, "/", "\") 
  Dim iPos
  iPos = InStrRev(strFileName, "\")
  PathRemoveFileSpec1 = Left(strFileName, iPos)
End Function
 
WScript.Echo PathRemoveFileSpec1(WScript.ScriptFullName)