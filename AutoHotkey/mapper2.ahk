#Requires AutoHotkey v2.0
#SingleInstance Force

; Other key remappings
RCtrl::LWin     
CapsLock::Escape             ; Caps Lock = Escape
Escape::CapsLock             ; Escape = Caps Lock

; QWERTY Row with RAlt
RAlt & q::Send "~"          ; AltGr+q = ! (fixed with braces)
RAlt & w::Send "``"           ; AltGr+w = &
RAlt & e::Send "{%}"           ; AltGr+e = |
RAlt & r::SendText "["          ; AltGr+r = `
RAlt & t::Send "$"           ; AltGr+t = %

; ASDF Row - Left-hand operators
RAlt & a::Send "="           ; AltGr+a = =
RAlt & s::Send "-"           ; AltGr+s = -
RAlt & d::Send "_"         ; AltGr+d = + (fixed with braces)
RAlt & f::Send "("           ; AltGr+f = _
RAlt & g::SendText "{"           ; AltGr+g = ~


; Navigation keys (HJKL Vim-style)
RAlt & h::Send "{Left}"      ; AltGr+h = ←
RAlt & j::Send "{Down}"      ; AltGr+j = ↓
RAlt & k::Send "{Up}"        ; AltGr+k = ↑
RAlt & l::Send "{Right}"     ; AltGr+l = →
RAlt & m::Send "@" 
; Bottom Row
RAlt & x::Send "{Delete}"    ; AltGr+x = Delete
RAlt & b::Send "{Backspace}" ; AltGr+b = Backspace
RAlt & n::Send "ñ"           ; AltGr+n = ñ

; Word-based editing (Ctrl combinations)
RAlt & c::Send "^{Delete}"   ; AltGr+c = Ctrl+Delete (delete word forward)
RAlt & v::Send "^{Backspace}" ; AltGr+v = Ctrl+Backspace (delete word backward)