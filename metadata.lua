return PlaceObj('ModDef', {
	'id', "MOG__Screenmeister",
	'title', "[MOG] Screenmeister",
	'image', "[MOG] Screenmeister.png",
	'author', "MyOneGod",
	'version_major', 1,
	'version', 1,
	'last_changes', "basic window handling",
	'ignore_files', {
		"*/.git/*",
		"*/.gitignore",
	},
	'lua_revision', 233360,
	'saved_with_revision', 350233,
	'default_options', {},
	'saved', 1721549708,
	'screenshot1', "Screenshots/[MOG] Screenmeister - 1. Unmodded.jpg",
	'screenshot2', "Screenshots/[MOG] Screenmeister - 2. FirstRun.jpg",
	'screenshot3', "Screenshots/[MOG] Screenmeister - 3. Settings.jpg",
	'screenshot4', "Screenshots/[MOG] Screenmeister - 4. Tray.png",
	'screenshot5', "Screenshots/[MOG] Screenmeister - 5. Blackboxed.jpg",
	'external_links', {
		"https://github.com/my-one-god/JA3--screenmeister",
	},
	'affected_resources', {},
	'TagGameSettings', true,
	'TagUI', true,
	'TagVisuals&Graphics', true,
	'description',
	"[h1]Screenmeister [MOG][/h1]"
	.."\n[b][i]Better fullscreen mode for JA3[/i][/b]"
	.."\n"
	.."\n[b]IMPORTANT: Switch to window mode before using this! You've been warned.[/b]"
	.."\n"
	.."\n[b]IMPORTANT: Run this from within the Mod folder (requires using the mod editor to unpack) or download it directly (easier):[/b]"
	.."\n[list]"
	.."\n[*][url=https://github.com/my-one-god/JA3--screenmeister/releases/download/v1.0/ScreenmeisterJA3.exe]Executable v1.0[/url]"
	.."\n[*][url=https://github.com/my-one-god/JA3--screenmeister/releases/latest]Latest release overview[/url]"
	.."\n[*][url=https://github.com/my-one-god/JA3--screenmeister]Source code[/url]"
	.."\n[/list]"
	.."\n"
	.."\n[h2]Features[/h2]"
	.."\n[h3]"
		.."[b]Play in better fullscreen mode[/b]"
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
	.."\n[h2]Intended Improvements[/h2]"
	.."\n[list]"
	.."\n[*]Nicer settings UI"
	.."\n[*]Cycle setups with hotkey (shift+F11)"
	.."\n[*]Proper multi-screen support"
	.."\n[/list]"
	.."\n"
	.."\n[h2]Known issues[/h2]"
	.."\n[list]"
	.."\n[*]"
		.."[b]IMPORTANT: Unfortunately, this is not really a mod but a tool you need to run separately.[/b]"
		.."Mods are sandboxed so that they cannot harm the user. At most, they can break the game and mess up your savegames. "
		.."That is a good thing! "
		.."As far as I can tell, there is no way to mod the game's window layout, which generally makes sense. "
		.."Therefore, there are only two ways for the game to get a nice fullscreen mode:"
		.."\n[olist]"
		.."\n[*]The game gets patched, either by the original devs or by the type of modder that brought us JA2 1.13"
		.."\n[*]An external tool, which this provides"
			.."\n[list]"
			.."\n[*]This does include the source"
			.."\n[/list]"
		.."\n[/olist]"
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
	.."\n[hr][/hr]"
	.."\n[b]NOTE[/b]"
		.."Technically, JA3's fullscreen is a borderless window, but unfortunately, it behaves somewhat like the old exclusive fullscreen. "
		.."Therefore, I reject the game's fullscreen setting. "
		.."If you have issues with the game's own fullscreen mode as I have, this is for you. You're welcome."
	.."\n[url=https://devblogs.microsoft.com/directx/demystifying-full-screen-optimizations/]According to MS, everything should just work[/url]"
		..", which means the developers are unlikely to ever change this."
})
