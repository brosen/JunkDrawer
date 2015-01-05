' This script will return the logged on user for the computer(s) listed.
' At the command line list the computer name(s) for each computer you
' want to run against. If the command is run alone it will run against the 
' computer the script is run from.
' i.e.
' "C:\loggedon.vbs" will run against the local computer or "."
' "C:\loggedon.vbs tstsrv001 tstsrv002" will run against the two servers "testsrv001" and "tstsrv002".

' Checking for computers to run against or local 
If Wscript.Arguments.Count = 0 Then
    arrComputers = Array(".")
Else
    Dim arrComputers()
    For i = 0 to Wscript.Arguments.Count - 1
        Redim Preserve arrComputers(i)
        arrComputers(i) = Wscript.Arguments(i)
    Next
End If
For Each strComputer in arrComputers
    Set objWMIService = GetObject("winmgmts:" _
		& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2") 
	Set colComputer = objWMIService.ExecQuery _
		("Select * from Win32_ComputerSystem")
 
 ' The script action occurs here and repeats for each computer listed
	For Each objComputer in colComputer
		Wscript.Echo "User """ & objComputer.UserName & """ logged onto computer """ & strComputer & """."
	Next
Next
