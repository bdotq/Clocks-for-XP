;MouseClock.ahk
; Shows the current time next to the mouse cursor, and date and more in the tray
;Skrommel @2005
;modified by bdotq

bg := 0x000000
fg := 0xFFFFFF
;fg := ((fg&255)<<16)+(((fg>>8)&255)<<8)+(fg>>16) ; rgb -> bgr 
;bg := ((bg&255)<<16)+(((bg>>8)&255)<<8)+(bg>>16) ; rgb -> bgr 

hFont := DllCall("CreateFont",uint,18 ;int nHeight
                              , int,0 ;int nWidth
                              , int,0 ;int nEscapement
                              , int,0 ;int nOrientation
                              , int,0 ;int fnWeight
                              , int,0 ;DWORD fdwItalic
                              , uint,0 ;DWORD fdwUnderline
                              , uint,0 ;DWORD fdwStrikeOut
                              , uint,0 ;DWORD fdwCharSet
                              , uint,0 ;DWORD fdwOutPutPrecision
                              , uint,0 ;DWORD fdwClipPrecision
                              , uint,0 ;DWORD fdwQuality
                              , uint,0 ;DWORD fdwPitchAndFamily
                              , str, "Tahoma") ; LPCTSTR lpszFace
                              

CoordMode,Mouse,Screen
CoordMode,ToolTip, Screen
TRAYTIPDATE:
StringTrimLeft,uke,A_YWeek,4
Menu,Tray,Tip,%A_DDDD% %A_DD%. %A_MMMM% %A_YYYY% - week %uke% - day %A_YDay%
START:
hr = %A_HOUR%
hr := Mod(hr, 12)
If (hr==0)
  hr:=12
tid1 = %hr%:%A_MIN%
If (A_HOUR >= 12)
  tid1=%tid1% PM
Else
  tid1=%tid1% A
MouseGetPos,x1,y1
If (y1>(A_ScreenHeight-30))
  y1:=A_ScreenHeight-93
If x2=%x1%
  If y2=%y1%
    If tid2=%tid1%
      Goto,UNMOVED

ToolTip,% (ttID:=tid1),A_ScreenWidth,y1+30
tThWnd1:=WinExist(ttID ahk_class tooltips_class32) 
; remove border 
;WinSet,Style,-0x800000,ahk_id %tThWnd1% 
;Transparency, default tooltip color is 0xFFFFE1
WinSet,TransColor,0xBBBBBB 180,%tid1%
SendMessage 0x30, hfont,0,, ahk_id %tThWnd1%
;SendMessage, 0x400+19, bg, fg,, ahk_id %tThWnd1% 
SendMessage, 0x413, bg,0,, ahk_id %tThWnd1% 
SendMessage, 0x414, fg,0,, ahk_id %tThWnd1% 


;extended style E0x20 to make the tooltip behave as if it wasn't there (clicks go through it)
;ToolTip,%tid1%,x1+1280,y1+30

UNMOVED:
Sleep,10
x2=%x1%
y2=%y1%
tid2=%tid1%
If (A_HOUR==0 and A_MIN==0)
  Goto,TRAYTIPDATE
Goto,START