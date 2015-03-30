--
-- Ion menu definitions
--


-- Load a library with some convenience functions.
include("menulib")
-- Load query support code
include("querylib")


-- Main menu
defmenu("mainmenu", {
    submenu("Programs", "appmenu"),
    menuentry("Lock screen", function(reg)
                                 exec_in(reg, lookup_script("ion-lock"))
                             end),
    menuentry("Help", querylib.query_man),
    menuentry("About Ion", querylib.show_aboutmsg),
    submenu("Styles", "stylemenu"),
    submenu("Debian", "Debian"),
    submenu("Exit", "exitmenu"),
})


-- Application menu
defmenu("appmenu", {
    -- The query module must also be loaded for this binding to work.
    menuentry("Run...", querylib.query_exec),
    menuentry("Terminal", make_exec_fn("uxterm")),
    menuentry("Browser", make_exec_fn("sensible-browser")),
})


-- Menu with restart/exit alternatives
defmenu("exitmenu", {
    --menuentry("Restart", querylib.query_restart),
    menuentry("Restart", restart_wm),
    menuentry("Restart PWM2", function() restart_other_wm("pwm2") end),
    menuentry("Restart TWM", function() restart_other_wm("twm") end),
    --menuentry("Exit", querylib.query_exit),
    menuentry("Exit", exit_wm),
})


-- Context menu (frame/client window actions)
defmenu("ctxmenu", {
    menuentry("Close", WMPlex.close_sub_or_self),
    menuentry("Kill", make_mplex_clientwin_fn(WClientWin.kill)),
    menuentry("(Un)tag", make_mplex_sub_fn(WRegion.toggle_tag)),
    menuentry("Attach tagged", WGenFrame.attach_tagged),
    menuentry("Clear tags", clear_tags),
})


-- Context menu for floating frames -- add sticky toggle.
defmenu("ctxmenu-floatframe", {
    menuentry("Close", WMPlex.close_sub_or_self),
    menuentry("Kill", make_mplex_clientwin_fn(WClientWin.kill)),
    menuentry("(Un)tag", make_mplex_sub_fn(WRegion.toggle_tag)),
    menuentry("Attach tagged", WGenFrame.attach_tagged),
    menuentry("Clear tags", clear_tags),
    menuentry("(Un)stick", function(f) f:toggle_sticky() end),
})

-- Auto-generated Debian menu definitions
if os.execute("test -x /usr/bin/update-menus") == 0 then
    if ioncore_is_i18n() then
        include("debian-menu-i18n")
    else
        include("debian-menu")
    end
end
