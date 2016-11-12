#NoTrayIcon
#include "Zip.au3"

;;;;;;;;;;;;;;;;;;;;;;;;;
;       UPDATER         ;
;;;;;;;;;;;;;;;;;;;;;;;;;

;startup, verifica atualizacoes, atualiza os ficheiros
$website = "http://botcentral.github.io"
;$location = "C:\PROGRA~2\GNU\GnuPG\etc\gtk-2.0\update\gtk\"
$location = "D:\Downloads\botCentralLabs\"

;Returns version number from remote server
Func getVersionFromWebsite()
   InetGet($website&"/version.ini", "version.ini")
   $remoteVersion = iniread("version.ini", "GENERAL", "version", "error")
   FileDelete($location&"version.ini")
   ;MsgBox(64, "VersionRead", $newVersion)
   Return $remoteVersion
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

;Deletes files specified by the version.ini
Func deleteFiles()
   InetGet($website&"/config.ini", "config.ini")
   $numFilesToDelete = Int(iniread("config.ini", "UPDATE-CONFIG", "number_delete", "error"))
   For $i = 1 To $numFilesToDelete
	  $fileToDelete = iniread("config.ini", "UPDATE-CONFIG", "delete_"&$i&, "error")
	  FileDelete($location&$fileToDelete)
   Next
EndFunc

;Downloads and uncompresses the update.zip
Func downloadUncompress()
   InetGet($website&"/update.zip", "update.zip")
   Return _Zip_UnzipAll($location&"update.zip", $location,0)
EndFunc


;Main Loop
If checkUpdate() Then
   deleteFiles()
   Sleep(2000)
   downloadUncompress()
   Sleep(2000)
EndIf


Run ($location&"script.exe","",@SW_HIDE)
Return 0