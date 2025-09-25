#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")

; Update 15
; Other key remappings
RCtrl::LWin     
LWin::Escape
Escape::CapsLock             ; Escape = Caps Lock

; QWERTY Row with RAlt
RAlt & q::Send("~")          ; AltGr+q = ~
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



; delete like vim 
>!x::Send("{Delete}")
>!+x::Send("{Backspace}")
>!+v::Send("{RCtrl down}{Delete}{RCtrl up}")
>!v::Send("{RCtrl down}{Backspace}{RCtrl up}")






