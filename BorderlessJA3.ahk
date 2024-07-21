#Requires AutoHotkey v2.0
#SingleInstance Force

A_IconTip := "Borderless Jagged Alliance 3"

IconPath := ".\JA3.ico"

TraySetIcon IconPath

;
;
;

A_TrayMenu.Delete
A_TrayMenu.Add("&Quit", (*) => ExitApp(0))

selectJA3Window := "ahk_class HaemimontGamesWindowClass1 ahk_exe JA3.exe"
idJA3Window := WinWait(selectJA3Window)

GroupAdd "JA3Borderless", selectJA3Window
groupWindows := "ahk_group JA3Borderless"

BlackBox := Gui("+ToolWindow -0xC00000", "Blackout screen for JA3")
; ToolWindow: no taskbar button, not shown in Task View (❖⭾)
; -0xC00000: borderless

BlackBox.BackColor := "Black"

; Create the settings window:
wSettings := Gui("AlwaysOnTop -MaximizeBox -MinimizeBox","Borderless")
wSettings.Open := False
wSettings.MarginX := 24
wSettings.MarginY := 24
wSettings.OnEvent("Close", (*) => toggleSettingsWindow(False))
wSettings.OnEvent("Escape", (*) => toggleSettingsWindow(False))

GroupAdd "JA3Borderless", "ahk_id " . wSettings.Hwnd

textarea := wSettings.AddEdit("r4 w96", "")

bSave := wSettings.AddButton("yp w96", "Save")
bSave.OnEvent("Click", Save)
Save(*) {
	global lResolutions := parseResolutions(textarea.Value)
	global selectedResolution

	sResolutions := ""
	resolutionValid := selectedResolution = "fullscreen"

	Loop lResolutions.Length {
		item := lResolutions[A_Index]

		sResolution := item.width . "x" . item.height
		If (sResolution = selectedResolution) {
			resolutionValid := true
		}

		sResolutions .= ";" . sResolution
	}

	setSetting("resolutions", SubStr(sResolutions, 2))

	If not resolutionValid {
		setSetting("resolution", "fullscreen")
		Reload()
		; `Reload` doesn't prevent the script from continuing while the reload is proceeding
		Pause()
	}

	Setup()
}

bCancel := wSettings.AddButton("y+15 w96", "Cancel")
bCancel.OnEvent("Click", Cancel)
Cancel(*) {
	Setup()
}

delimiterResolutions := ";"

getSetting(key) {
	Return IniRead(IniPath, "Settings", key)
}
setSetting(key, value) {
	Return IniWrite(value, IniPath, "Settings", key)
}
getState(key) {
	Return IniRead(IniPath, "State", key)
}
setState(key, value) {
	Return IniWrite(value, IniPath, "State", key)
}

parseResolutions(sResolutions) {
	items := []

	Loop Parse sResolutions, "`n`r;," {
		item := StrSplit(RegExReplace(A_LoopField, "[^\dx*/]", ""), ["x","*","/"])

		If item.Length = 2 {
			height := Trim(item.Pop())
			width := Trim(item.Pop())

			If width and height {
				items.Push({
					width: Number(width),
					height: Number(height),
				})
			}
		}
	}

	return items
}

lResolutions := []
IniPath := A_AppData . "\JA3mod.MOG.Borderless.ini"
AttributeString := FileExist(IniPath)
If AttributeString {
	global active := getState("active")
	global lResolutions := parseResolutions(getSetting("resolutions"))
	Setup
} Else {
	FirstRun
}

;
;
;

FirstRun() {
	MsgBox(
		"This seems to be the first time you use the JA3 mod [MOG] Borderless."
		. "`n`nBefore toggling borderless mode, please make sure that JA3 is set to 'Windowed', not 'Fullscreen'!"
		. "`n`nTo toggle borderless mode, hit F11."
		. "`nThe settings window will be opened when you close this message."
		. "`nTo show it in the future, use the popup menu from the taskbar icon or hit Ctrl+F11."
		. "`n`nHave fun! :)"
		, A_IconTip
	)

	resolutionsDefault := "1920x1080" . delimiterResolutions . "1280x720"
	setSetting("resolutions", resolutionsDefault)
	setSetting("resolution", "fullscreen")

	setState("active", true)
	setState("version", 1)

	global lResolutions := parseResolutions(resolutionsDefault)
	global active := false

	Setup

	global active := true

	toggleSettingsWindow(True)
}

Setup() {
	toggleSettingsWindow(False)

	global selectedResolution := getSetting("resolution")
	A_TrayMenu.Delete
	A_TrayMenu.Add("F11", (*)=>{})
	A_TrayMenu.Disable("F11")

	AddResolution(A_ScreenWidth, A_ScreenHeight, "fullscreen", "fullscreen")

	textarea.Value := ""

	Loop lResolutions.Length {
		Width := lResolutions[A_Index].width
		Height := lResolutions[A_Index].height
		Id := Width . "x" . Height
		Label := Width . " × " . Height

		AddResolution(Width, Height, Id, Label)
	}

	A_TrayMenu.Add()
	A_TrayMenu.Add("&Settings – ᴄᴛʀʟ+F11", (*) => toggleSettingsWindow())
	A_TrayMenu.Add("&Quit", (*) => ExitApp(0))

	WinActivate(idJA3Window)

	if active {
		enableBoxWindow()
	}
}

;
;
;

AddResolution(Width, Height, Id, Label) {
	A_TrayMenu.Add(Label, Update)

	textarea.Value .= Width . " x " . Height . "`n"

	static ActiveItem := Label
	If (selectedResolution = Id) {
		Update(Label, 0, A_TrayMenu)
	}

	Update(ItemName, _, Menu) {
		Menu.Uncheck(ActiveItem)
		ActiveItem := ItemName
		Menu.Check(ItemName)

		setSetting("resolution", Id)
		global selectedResolution := Id

		global targetWidth := Width
		global targetHeight := Height
	}
}

InstallMouseHook
DetectHiddenWindows True

OnExit((ExitReason, ExitCode) => ClipCursor(False))
OnExit((ExitReason, ExitCode) => ShowTaskbar())

#HotIf WinActive(groupWindows)
	F11::toggleBoxWindow()
	^F11::toggleSettingsWindow()
#HotIf

ping
ping() {
	WinWaitActive(groupWindows)
	if active {
		enableBoxWindow()
	}
	pong()
}
pong() {
	WinWaitNotActive(groupWindows)
	disableBoxWindow()
	ping()
}

;
;
;

toggleSettingsWindow(Show := "") {
	global wSettings

	If wSettings.Open and Show = "" {
		wSettings.Open := False
		wSettings.Hide()
		enableBoxWindow()
	} Else If Show = False {
		wSettings.Open := False
		wSettings.Hide()
	} Else {
		wSettings.Open := True
		wSettings.Show()
	}
}
toggleBoxWindow() {
	global active

	If active {
		triggerWindow := WinGetID("A")
		setState("active", false)
		active := false
		disableBoxWindow()
		WinActivate(triggerWindow)
	} Else {
		setState("active", true)
		active := true
		enableBoxWindow()
	}
}

disableBoxWindow() {
	ShowTaskbar()
	ClipCursor(False)
	BlackBox.Hide()

	global idJA3Window
	If not WinExist(idJA3Window) {
		idJA3Window := WinWait(selectJA3Window)
	}
}

enableBoxWindow() {
	; https://gaming.stackexchange.com/a/17307
	WinSetStyle("-0xC00000", idJA3Window) ; hide title bar
	WinSetStyle("-0x800000", idJA3Window) ; hide thin-line border[]
	WinSetStyle("-0x400000", idJA3Window) ; hide dialog frame
	WinSetStyle("-0x40000", idJA3Window) ; hide thickframe/sizebox

	MonitorPrimary := MonitorGetPrimary()
	MonitorGet MonitorPrimary, &mL, &mT, &mR, &mB
	mW := mR - mL ; m* for consistency, equivalent to `mW := A_ScreenWidth`
	mH := mB - mT ; m* for consistency, equivalent to `mH := A_ScreenHeight`

	global targetWidth, targetHeight
	W := Min(targetWidth, mW)
	H := Min(targetHeight, mH)

	L := (mW/2)-(W/2)
	R := L + W

	T := (mH/2)-(H/2)
	B := T + H

	WinMove(L, T, W, H, idJA3Window)
	BlackBox.Show("NoActivate")
	BlackBox.Move( mL, mT, mW, mH )

	; unfortunately, `WinMoveTop` doesn't work
	; WinMoveTop BlackBox.Hwnd
	; WinMoveTop idJA3Window
	WinSetAlwaysOnTop(True, BlackBox.Hwnd)
	WinSetAlwaysOnTop(True, idJA3Window)
	; WinSetAlwaysOnTop(True, wSettings)

	WinSetAlwaysOnTop(False, BlackBox.Hwnd)
	WinSetAlwaysOnTop(False, idJA3Window)
	; WinSetAlwaysOnTop(False, wSettings)

	if (wSettings.Open) {
		WinActivate(wSettings)
	} else {
		WinActivate(idJA3Window)
	}

	ClipCursor(True, L, T, R, B)
	HideTaskbar()
}

;
;
;

ShowTaskbar() {
	WinShow "ahk_class Shell_TrayWnd"
}
HideTaskbar() {
	WinHide "ahk_class Shell_TrayWnd"
}

; https://www.autohotkey.com/boards/viewtopic.php?t=66966
ClipCursor(Confine:=True, left:=0, top:=0, right:=A_ScreenWidth, bottom:=A_ScreenHeight) {
	local Rect := 0x0

	If Confine {
		Rect := Buffer(16)

		NumPut("int", left, Rect)
		NumPut("int", top, Rect, 4)
		NumPut("int", right, Rect, 8)
		NumPut("int", bottom, Rect, 12)
	}

	DllCall("ClipCursor", "Ptr", Rect)
}
