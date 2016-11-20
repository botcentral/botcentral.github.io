#include <Date.au3>

while 1
   $nowTime = _NowTime(4)
   if (stringCompare($nowTime,"05:00") > 0 And stringCompare($nowTime,"06:00") < 0) Then
	  sleep(3600000) ; 1 hora
   Else
   $handler = WinActivate("WakeMeOnLan");
   if ($handler <> 0) Then
   Send("^a")
   sleep(1000)
   Send("{F8}")
   sleep(1000)
   Send("{ENTER}")
   sleep(1000)
   WinSetState("WakeMeOnLan","",@SW_MINIMIZE)
   EndIf
   sleep(300000) ; 5 min
EndIf
WEnd
