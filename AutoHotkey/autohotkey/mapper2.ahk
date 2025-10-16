#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
; Update 30 - Enhanced focus navigation to only visible windows
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
; Window focus navigation with Ctrl+Shift+H/L
^+h::FocusWindowInDirection("left")   ; Ctrl+Shift+h = Focus window to the left
^+l::FocusWindowInDirection("right")  ; Ctrl+Shift+l = Focus window to the right
; Window minimize/maximize with Ctrl+Shift+N/M
^+n::WinMinimize("A")        ; Ctrl+Shift+n = Minimize active window
^+m::ToggleMaximize()        ; Ctrl+Shift+m = Toggle maximize/restore active window
; Move current window to adjacent desktop with Ctrl+Shift+U/I
^+u::MoveWindowToDesktop(-1)  ; Move window to previous desktop
^+i::MoveWindowToDesktop(1)   ; Move window to next desktop

; Function to check if a window is truly visible (not minimized, not behind other windows)
IsWindowTrulyVisible(hwnd) {
    try {
        ; Check if window exists
        if (!WinExist("ahk_id " . hwnd))
            return false
            
        ; Check if window has a title (filters out many background windows)
        title := WinGetTitle("ahk_id " . hwnd)
        if (!title || title = "")
            return false
            
        ; Check if window is minimized
        minMaxState := WinGetMinMax("ahk_id " . hwnd)
        if (minMaxState = -1)
            return false
            
        ; Check if window is visible (has WS_VISIBLE style)
        style := WinGetStyle("ahk_id " . hwnd)
        if (!(style & 0x10000000))  ; WS_VISIBLE = 0x10000000
            return false
            
        ; Check if window is cloaked (hidden by virtual desktop or other means)
        cloaked := 0
        DllCall("dwmapi\DwmGetWindowAttribute", "Ptr", hwnd, "UInt", 14, "Int*", &cloaked, "UInt", 4)
        if (cloaked != 0)
            return false
            
        ; Get window position and size
        WinGetPos(&x, &y, &w, &h, "ahk_id " . hwnd)
        
        ; Check if window has valid dimensions
        if (w <= 0 || h <= 0)
            return false
            
        ; Check the center point of the window to see if it's actually visible
        centerX := x + (w / 2)
        centerY := y + (h / 2)
        
        ; Get the window at this point
        ; VarSetCapacity removed in v2, use Buffer instead
        point := Buffer(8)
        NumPut("Int", centerX, point, 0)
        NumPut("Int", centerY, point, 4)
        
        hwndAtPoint := DllCall("WindowFromPoint", "Int64", NumGet(point, "Int64"), "Ptr")
        
        ; If the window at the center point is not our window or a child of our window, it's covered
        if (hwndAtPoint != hwnd) {
            ; Check if hwndAtPoint is a child of hwnd
            parentHwnd := DllCall("GetAncestor", "Ptr", hwndAtPoint, "UInt", 2, "Ptr")  ; GA_ROOT = 2
            if (parentHwnd != hwnd)
                return false
        }
        
        return true
    }
    catch {
        return false
    }
}

FocusWindowInDirection(direction) {
    try {
        ; Get current active window
        currentHwnd := WinGetID("A")
        currentWin := WinGetPos(&currentX, &currentY, &currentW, &currentH, "ahk_id " . currentHwnd)
        currentCenterX := currentX + (currentW / 2)
        currentCenterY := currentY + (currentH / 2)
        
        ; Get all visible windows
        windows := WinGetList()
        
        bestWindow := 0
        bestDistance := 999999
        
        ; Loop through all windows
        for hwnd in windows {
            ; Skip if it's the current window
            if (hwnd = currentHwnd)
                continue
            
            ; Skip if window is not truly visible
            if (!IsWindowTrulyVisible(hwnd))
                continue
                
            ; Get window position
            try {
                WinGetPos(&x, &y, &w, &h, "ahk_id " . hwnd)
                centerX := x + (w / 2)
                centerY := y + (h / 2)
                
                ; Check if window is in the correct direction
                if (direction = "left" && centerX < currentCenterX) {
                    distance := Abs(currentCenterX - centerX) + Abs(currentCenterY - centerY)
                    if (distance < bestDistance) {
                        bestDistance := distance
                        bestWindow := hwnd
                    }
                }
                else if (direction = "right" && centerX > currentCenterX) {
                    distance := Abs(centerX - currentCenterX) + Abs(currentCenterY - centerY)
                    if (distance < bestDistance) {
                        bestDistance := distance
                        bestWindow := hwnd
                    }
                }
            }
        }
        
        ; Activate the best window found
        if (bestWindow != 0) {
            WinActivate("ahk_id " . bestWindow)
        }
    }
}


MoveWindowToDesktop(direction) {
    global dllPath
    
    ; Get active window - check if one exists first
    try {
        hwnd := WinGetID("A")
    } catch {
        ; No active window, exit silently
        return
    }
    
    ; Additional check to ensure window is valid
    if (!hwnd || !WinExist("ahk_id " . hwnd)) {
        return
    }
    
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



; Window snapping with Ctrl+Alt+H/J/K/L (use Left Ctrl specifically)
<^!h::Send("#{Left}")         ; Left Ctrl+Alt+h = Snap window to left
<^!j::Send("#{Down}")         ; Left Ctrl+Alt+j = Minimize/Restore window
<^!k::Send("#{Up}")           ; Left Ctrl+Alt+k = Maximize/Restore window
<^!l::Send("#{Right}")        ; Left Ctrl+Alt+l = Snap window to right



; Mouse 

MButton::Enter










