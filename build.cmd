@echo off

ml /c /coff Lenstr.asm || goto ErrLable

lib /subsystem:windows /export:Lenstr Lenstr.obj

ml /c /coff ReverStr.asm || goto ErrLable

lib /subsystem:windows /export:ReverStr ReverStr.obj

ml /c /coff StrToNum.asm || goto ErrLable

lib /subsystem:windows /export:StrToNum StrToNum.obj

ml /c /coff Reconversion.asm || goto ErrLable

lib /subsystem:windows /export:Reconversion Reconversion.obj

ml /c /coff TestStr.asm || goto ErrLable

lib /subsystem:windows /export:TestStr TestStr.obj

ml /c /coff SizeOfNum.asm || goto ErrLable

lib /subsystem:windows /export:SizeOfNum SizeOfNum.obj

goto TheEnd

:ErrLable
echo Error

:TheEnd
pause