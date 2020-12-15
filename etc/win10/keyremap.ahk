; replaces the old instance automatically
#SingleInstance force

;====== keyremap ===================================================
    ; keyremap
    CapsLock::RCtrl
    RAlt::Esc
    Launch_Mail::CapsLock
;====== End keyremap ===================================================

;====== control win transparent===================================================
    #=:: ;����͸�������ӻ��߼���
        WinGet, ow, id, A
        WinTransplus(ow)
        return
    #-:: ;����͸�������ӻ��߼���
        WinGet, ow, id, A
        WinTransMinus(ow)
        return
    WinTransplus(w){
        WinGet, transparent, Transparent, ahk_id %w%
        if transparent < 255
            transparent := transparent+10
        else
            transparent =
        if transparent
            WinSet, Transparent, %transparent%, ahk_id %w%
        else
            WinSet, Transparent, off, ahk_id %w%
        return
    }
    WinTransMinus(w){
        WinGet, transparent, Transparent, ahk_id %w%
        if transparent
            transparent := transparent-10
        else
            transparent := 240
        WinSet, Transparent, %transparent%, ahk_id %w%
        return
    }
;====== End control win transparent===================================================

;======= DEBUG Active Window =====================================================
    !enter::
        WinGet ow, id, A
        WinGet pp, processPath, A
        WinGet pn, processname, A
        WinGetTitle, oTitle, ahk_id %ow%
        WinGetClass, oClass, ahk_id %ow%
        WinGetText, oText, ahk_id %ow%
        clipboard= %ow%      %oTitle%    %oClass%  %oText%   %pp%  %pn%
        tooltip %clipboard%
        return
;======= End debug active window =====================================================

;======= top win ==================================================
    #enter:: ;�����֮�����ö�
        WinGet ow, id, A
        WinGet pp, processPath, A
        WinGet pn, processname, A
        WinGetTitle, oTitle, ahk_id %ow%
        WinGetClass, oClass, ahk_id %ow%
        WinGetText, oText, ahk_id %ow%
        clipboard= %ow%      %oTitle%    %oClass%  %oText%   %pp%  %pn%
        tooltip %clipboard%
        WinTopToggle(ow)
        return
        WinTopToggle(w) {
            WinGetTitle, oTitle, ahk_id %w%
            Winset, AlwaysOnTop, Toggle, ahk_id %w%
            WinGet, ExStyle, ExStyle, ahk_id %w%
            if (ExStyle & 0x8)  ; 0x8 Ϊ WS_EX_TOPMOST.��WinGet�İ�����
                oTop = �ö�
            else
                oTop = ȡ���ö�
            tooltip %oTitle% %oTop%
            SetTimer, RemoveToolTip, 5000
            return
        
            RemoveToolTip:
            SetTimer, RemoveToolTip, Off
            ToolTip
            return
        }

        #x:: ;�رմ���
        send ^w
    return
;======= End top win ==================================================

;== Arrow key map=======================================================
    LAlt & u::send {PgUp}
    LAlt & d::send {PgDn}
    LAlt & h::send {Left}
    LAlt & j::send {Down}
    LAlt & k::send {Up}
    LAlt & l::send {Right}

    ; LAlt & m::send,{Shift}{Home}
    ; LAlt & m::send,^m
    ; LAlt & m::send {Ctrl}m
;== End Arrow key map=======================================================

;==== Hotkey for app =====================================================
; Notepad - Activate an existing notepad.exe window, or open a new one
    !n::
        WinActiveToggle("notepad.exe", "Notepad") 
        return
; wxwork
    !w::
        WinActiveToggle("WXWork.exe", "C:\Program Files (x86)\WXWork\WXWork.exe") 
        return
; foxit
    !f::
        WinActiveToggle("FoxitReader.exe", "C:\Program Files (x86)\Foxit Software\Foxit Reader\FoxitReader.exe ") 
        return
; qq
    !q::
        WinActiveToggle("QQ.exe", "C:\Program Files (x86)\Tencent\QQ\Bin\QQ.exe") 
        return
; vscode
    !v::
        WinActiveToggle("Code.exe", "C:\Users\zhuangyulin\AppData\Local\Programs\Microsoft VS Code\Code.exe") 
        return
; MobaXterm
        WinActiveToggle("MobaXterm.exe", "C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe") 
        return
; chrome
    !c::
        ; var1 := "chrome.exe"
        ; var2 := "C:\Program Files (x86)\Google\Chrome Dev\Application\chrome.exe "
        ; WinActiveToggle(var1, var2) 
        WinActiveToggle("chrome.exe", "C:\Program Files (x86)\Google\Chrome Dev\Application\chrome.exe") 
        return
WinActiveToggle(win_exe, run_exe) {
    if WinExist("ahk_exe" win_exe) {
        if WinActive("ahk_exe" win_exe) {
            ; WinClose  ;   Uses the last found window.
            WinHide, ahk_exe %win_exe%
            msgbox closing
        } else {
            WinActivate, ahk_exe %win_exe%
            msgbox activing
        }
    } else {
        msgbox running %run_exe%
        run %run_exe%
    }
    return
}
;==== End Hotkey for app =====================================================


;���Ӱ�����֮������������
;======= ������������ ==================================================
    ~lbutton & enter:: ;����������������������ʵ�������ļӼ�
        exitapp  
    ~WheelUp::  
        if (existclass("ahk_class Shell_TrayWnd")=1)  
            Send,{Volume_Up}  
        Return  
    ~WheelDown::  
            if (existclass("ahk_class Shell_TrayWnd")=1)  
            Send,{Volume_Down}  
        Return  
    ~MButton::  
        if (existclass("ahk_class Shell_TrayWnd")=1)  
            Send,{Volume_Mute}  
        Return  
    Existclass(class) {  
        MouseGetPos,,,win  
        WinGet,winid,id,%class%  
        if win = %winid%  
            Return,1  
        Else  
            Return,0  
    }
;======= End ������������ ==================================================

;======== Copy file path =================================================
    #+c:: ;�ÿ�ݼ��õ���ǰѡ���ļ���·��
    send ^c
    sleep,200
    clipboard=%clipboard% ;windows ���Ƶ�ʱ�򣬼����屣����ǡ�·������ֻ��·�������ַ�����ֻҪת�����ַ����Ϳ���ճ��������
    tooltip,%clipboard% ;��ʾ�ı�
    sleep,2000
    tooltip,
    return
;======== End copy file path =================================================

;======== timer =================================================
    #+t:: ;С��ԭ��-�޵й�������֮�ռ���ʱ��
    var := 0
    InputBox, time, С�����ü�ʱ��, ������һ��ʱ�䣨��λ�Ƿ֣�
    time := time*60000
    Sleep,%time%
    loop,16
    {
    var += 180
    SoundBeep, var, 500
    }
    msgbox ʱ�䵽������������������𣡣����л��㱣�����
    return
;======== End timer=================================================

;======== Hot strings =================================================
    :*:iid::  ; �����ִ�ͨ������������ִ��滻�ɵ�ǰ���ں�ʱ��.
    FormatTime, CurrentDateTime,, MM��dd ; ��ʽ��С��01��17��Ƭ
    ;FormatTime, CurrentDateTime,, MM��dd-HH��-mm-ss ; ��ʽ��С��08��16-11��-43-51��Ƭ
    SendInput С��%CurrentDateTime%��Ƭ
    return
    :*:autoh:: ;�Զ�����AutoHotkey
    clipboard = AutoHotkey
    send,^v
    return
;======== End Hot strings =================================================

;======== google search ================================================
    #9:: ;��google�������а������
    run https://www.google.com/search?q=%clipboard%
    tooltip, ������Ҳ������Ҳ��������
    sleep 2000
    tooltip,
    return
;======== End google search ================================================

;======== some example ==================================================
    #1:: ;ѭ�����ʾ��, 0.2s
    loop, 10
    {
    click
    sleep 200
    }
    return

    ; #z::Run https://www.autohotkey.com  ; Win+Z

    InputBox, ov, TEST, input sth
    tooltip %ov%

    WinActivate, ahk_class ConsoleWindowClass

    id := WinExist("A")
    MsgBox % id
;======== End some example ==================================================