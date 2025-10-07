#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
; Update 28 - Removed directional window focus
; Load VirtualDesktopAccessor.dll from same folder as script
dllPath := A_ScriptDir . "\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", dllPath, "Ptr")

; Other key remappings
RCtrl::LWin     
LWin::Escape
Escape::CapsLock             ; Escape = Caps Lock

; QWERTY Row with RAlt
RAlt & q::Send("!{F4}")      ; AltGr+q = Alt+F4 (close window)
RAlt & w::Send("``")         ; AltGr+w = `
RAlt & e::Send("{%}")        ; AltGr+e = %
RAlt & r::SendText("+")      ; AltGr+r = +
RAlt & t::Send("$")          ; AltGr+t = $

; ASDF Row - Left-hand operators
RAlt & a::Send("=")          ; AltGr+a = =
RAlt & s::Send("-")          ; AltGr+s = -
RAlt & d::Send("_")          ; AltGr+d = _
RAlt & f::Send("(")          ; AltGr+f = (
RAlt & g::SendText("{")      ; AltGr+g = {

; Navigation keys (HJKL Vim-style) - These stay with RAlt
RAlt & h::Send("{Left}")     ; AltGr+h = ←
RAlt & j::Send("{Down}")     ; AltGr+j = ↓
RAlt & k::Send("{Up}")       ; AltGr+k = ↑
RAlt & l::Send("{Right}")    ; AltGr+l = →
RAlt & m::Send("@")

; esp dist
RAlt & n::Send("ñ")          ; AltGr+n = ñ

#x::WinClose("A")   

; delete like vim 
>!x::Send("{Delete}")
>!+x::Send("{Backspace}")
>!+v::Send("{RCtrl down}{Delete}{RCtrl up}")
>!v::Send("{RCtrl down}{Backspace}{RCtrl up}")

; Desktop switching with Ctrl+Shift+J/K
^+j::Send("#^{Left}")        ; Ctrl+Shift+j = Switch to left desktop
^+k::Send("#^{Right}")       ; Ctrl+Shift+k = Switch to right desktop

; Window minimize/maximize with Ctrl+Shift+N/M
^+n::WinMinimize("A")        ; Ctrl+Shift+n = Minimize active window
^+m::ToggleMaximize()        ; Ctrl+Shift+m = Toggle maximize/restore active window

; Move current window to adjacent desktop with Ctrl+Shift+U/I
^+u::MoveWindowToDesktop(-1)  ; Move window to previous desktop
^+i::MoveWindowToDesktop(1)   ; Move window to next desktop




MoveWindowToDesktop(direction) {
    global dllPath
    
    ; Get active window
    hwnd := WinGetID("A")
    
    ; Get current desktop index
    currentDesktop := DllCall(dllPath . "\GetCurrentDesktopNumber", "Int")
    
    ; Calculate target desktop
    targetDesktop := currentDesktop + direction
    
    ; Get desktop count to wrap around
    desktopCount := DllCall(dllPath . "\GetDesktopCount", "Int")
    
    ; Wrap around if needed
    if (targetDesktop < 0)
        targetDesktop := desktopCount - 1
    else if (targetDesktop >= desktopCount)
        targetDesktop := 0
    
    ; Move window to target desktop
    DllCall(dllPath . "\MoveWindowToDesktopNumber", "Ptr", hwnd, "Int", targetDesktop)
    
    ; Switch to that desktop
    DllCall(dllPath . "\GoToDesktopNumber", "Int", targetDesktop)
}

ToggleMaximize() {
    ; Get current window state
    try {
        state := WinGetMinMax("A")
        
        if (state = 1) {
            ; Window is maximized, restore it
            WinRestore("A")
        } else {
            ; Window is not maximized, maximize it
            WinMaximize("A")
        }
    }
}