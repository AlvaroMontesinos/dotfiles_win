#Requires AutoHotkey v2.0
#SingleInstance Force

; Map LWin to Escape, then swap Escape with Caps Lock (using scan codes to avoid conflicts)
LWin::Send "{Escape}"        ; Left Windows key = Escape
CapsLock::Escape             ; Caps Lock = Escape
Escape::CapsLock             ; Escape = Caps Lock

; QWERTY Row with RAlt
RAlt & q::Send "!"           ; AltGr+q = !
RAlt & w::Send "&"           ; AltGr+w = &
RAlt & e::Send "|"           ; AltGr+e = |
RAlt & r::Send "``"          ; AltGr+r = `
RAlt & t::Send "%"           ; AltGr+t = %

; ASDF Row - Left-hand operators
RAlt & a::Send "="           ; AltGr+a = =
RAlt & s::Send "-"           ; AltGr+s = -
RAlt & d::Send "+"           ; AltGr+d = +
RAlt & f::Send "_"           ; AltGr+f = _
RAlt & g::Send "~"           ; AltGr+g = ~

; Navigation keys (HJKL Vim-style)
RAlt & h::Send "{Left}"      ; AltGr+h = ←
RAlt & j::Send "{Down}"      ; AltGr+j = ↓
RAlt & k::Send "{Up}"        ; AltGr+k = ↑
RAlt & l::Send "{Right}"     ; AltGr+l = →

; Bottom Row
RAlt & x::Send "{Delete}"    ; AltGr+x = Delete
RAlt & b::Send "{Backspace}" ; AltGr+b = Backspace
RAlt & n::Send "ñ"           ; AltGr+n = ñ

; Word-based editing (Ctrl combinations)
RAlt & c::Send "^{Delete}"   ; AltGr+c = Ctrl+Delete (delete word forward)
RAlt & v::Send "^{Backspace}" ; AltGr+v = Ctrl+Backspace (delete word backward)