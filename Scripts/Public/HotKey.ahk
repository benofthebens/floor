#Requires AutoHotkey v2.0

^!+f::{
     If WinActive("ahk_class CabinetWClass"){
          text := WinGetText("A")
          lines := StrSplit(text,"`n")
          Run ("powershell.exe cd " . lines[1] . "; Rename-Files")
     }
}
