--
-- Ion main configuration file
--

-- Set default modifier. Alt should usually be mapped to Mod1 on
-- XFree86-based systems. The flying window keys are probably Mod3
-- or Mod4; see the output of 'xmodmap'.
-- DEFAULT_MOD = "Mod1+"
DEFAULT_MOD = "Mod4+"

-- set default window type to float
default_ws_type ="WFloatWS"
-- default_ws_type ="WIonWS"

-- Maximum delay between clicks in milliseconds to be considered a
-- double click.
--set_dblclick_delay(250)

-- For keyboard resize, time (in milliseconds) to wait after latest
-- key press before automatically leaving resize mode (and doing
-- the resize in case of non-opaque move).
--set_resize_delay(1500)

-- Opaque resize?
enable_opaque_resize(false)

-- Movement commands warp the pointer to frames instead of just
-- changing focus. Enabled by default.
enable_warp(true)

-- Kludges to make apps behave better.
include("kludges")

-- Make some bindings.
include("ion-bindings")

-- Define some menus (menu module required to actually use them)
include("ion-menus")

-- How to shorten window titles when the full title doesn't fit in
-- the available space? The first-defined matching rule that succeeds 
-- in making the title short enough is used.
add_shortenrule("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2")
add_shortenrule("(.*) - Mozilla", "$1$|$1$<...")
add_shortenrule("XMMS - (.*)", "$1$|...$>$1")
add_shortenrule("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
add_shortenrule("[^:]+: (.*)", "$1$|$1$<...")
add_shortenrule("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
add_shortenrule("(.*)", "$1$|$1$<...")

-- List of directories to look for manuals in the F1 man page query.
query_man_path={
    "/usr/man",
    "/usr/share/man",
    "/usr/X11R6/man",
    "/usr/local/man"
}

-- Modules.
load_module("query")
load_module("menu")
load_module("ionws")
load_module("floatws")
-- load_module("dock")
