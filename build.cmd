@echo off

ml /c /coff c:\masm32\projects\numlib\src\main\Lenstr.asm || goto ErrLable

lib /subsystem:windows /export:Lenstr Lenstr.obj

ml /c /coff c:\masm32\projects\numlib\src\main\ReverStr.asm || goto ErrLable

lib /subsystem:windows /export:ReverStr ReverStr.obj

ml /c /coff c:\masm32\projects\numlib\src\main\StrToNum.asm || goto ErrLable

lib /subsystem:windows /export:StrToNum StrToNum.obj

ml /c /coff c:\masm32\projects\numlib\src\main\atodw.asm || goto ErrLable

lib /subsystem:windows /export:atodw atodw.obj

ml /c /coff c:\masm32\projects\numlib\src\main\Reconversion.asm || goto ErrLable

lib /subsystem:windows /export:Reconversion Reconversion.obj

ml /c /coff c:\masm32\projects\numlib\src\main\TestStr.asm || goto ErrLable

lib /subsystem:windows /export:TestStr TestStr.obj

ml /c /coff c:\masm32\projects\numlib\src\main\SizeOfNum.asm || goto ErrLable

lib /subsystem:windows /export:SizeOfNum SizeOfNum.obj

del Lenstr.obj || goto ErrLable

del ReverStr.obj || goto ErrLable

del Lenstr.lib || goto ErrLable

del ReverStr.lib || goto ErrLable

del StrToNum.obj || goto ErrLable

del StrToNUm.lib || goto ErrLable

del Reconversion.obj || goto ErrLable

del Reconversion.lib || goto ErrLable

del TestStr.obj || goto ErrLable

del TestStr.lib || goto ErrLable

del atodw.lib || goto ErrLable

del SizeOfNum.lib || goto ErrLable

del atodw.obj || goto ErrLable

del SizeOfNum.obj || goto ErrLable

goto TheEnd

:ErrLable
echo Error

:TheEnd
pause