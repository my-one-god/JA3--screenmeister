return PlaceObj('ModDef', {
	'id', "MOG__Borderless",
	'title', "[MOG] Borderless",
	'image', "[MOG] Borderless.png",
	'author', "MyOneGod",
	'version', 1,
	'lua_revision', 233360,
	'saved_with_revision', 350233,
	'default_options', {},
	'saved', 1719807250,
	'TagGameSettings', true,
	'TagUI', true,
	'TagVisuals&Graphics', true,
	'description',
	"[h1]Borderless [MOG][/h1]"
	.."\n[b][i]Borderless Window mode for JA3[/i][/b]"
	.."\n"
	.."\n[b]IMPORTANT: Switch to window mode before using this! You've been warned.[/b]"
	.."\n"
	.."\n[h2]Features[/h2]"
	.."\n[h3]"
		.."[b]Play in Borderless Window mode[/b]"
		..": The missing Display setting"
	.."\n[/h3]"
	.."\n[list]"
	.."\n[*]Alt+Tab without weird happenings, because it's a window"
	.."\n[*]Clamp mouse to game window, while game is active"
	.."\n[*]Set any resolution you want"
	.."\n[*]You can setup multiple viewport sizes, e.g. for use on different screens"
	.."\n[*]Hit F11 to enable/disable"
	.."\n[*]Hit ctrl+F11 to show the settings window"
	.."\n[/list]"
	.."\n"
	.."\n[h2]Known issues[/h2]"
	.."\n[list]"
	.."\n[*][b]If used while the game is in its own fullscreen mode, strange things may happen, so just don't[/b]"
	.."\n[*]"
		.."The way this works, it cannot force the JA3 output to scale, "
		.."so if your machine cannot handle fullscreen resolution, "
		.."you will get a black backdrop. No idea if and how this can be fixed, sorry"
	.."\n[*]In rare cases, switching from and to JA3 a lot may make the tool lose track"
	.."\n[*]"
		.."When switching out of the game and switching back in, there will shortly be a title bar – "
		.."this is due to the game's behavior and I have not found a way to prevent that, "
		.."but it does no harm to the game"
	.."\n[*]Works for primary screen only"
	.."\n[/list]"
})
