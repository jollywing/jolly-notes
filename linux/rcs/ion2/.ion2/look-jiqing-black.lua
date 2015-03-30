-- look-wheat2.lua drawing engine configuration file for Ion.

if not gr_select_engine("de") then return end

de_reset()

de_define_style("*", {
    shadow_colour = "white",
    highlight_colour = "white",
    background_colour = "black",
    foreground_colour = "white",
    padding_pixels = 0,
    highlight_pixels = 1,
    shadow_pixels = 0,
    border_style = "elevated",
    font = "-*-wenquanyi bitmap song-*-*-*-*-14-*-*-*-*-*-gbk-*",
    text_align = "center",
})

de_define_style("frame", {
    based_on = "*",
    shadow_colour = "white",
    highlight_colour = "white",
    padding_colour = "white",
    background_colour = "black",
    foreground_colour = "white",
    padding_pixels = 0,
    highlight_pixels = 0,
    shadow_pixels = 1,
    de_substyle("active", {
        shadow_colour = "orange",
        highlight_colour = "orange",
        background_colour = "black",
        foreground_colour = "white",
    }),
})

de_define_style("frame-ionframe", {
    based_on = "frame",
    border_style = "elevated",
    padding_pixels = 0,
    spacing = 0,
    ionframe_bar_inside_border = true,
})

de_define_style("frame-floatframe", {
    based_on = "frame",
    border_style = "ridge"
})

de_define_style("tab", {
    based_on = "*",
    font = "-*-wenquanyi bitmap song-*-*-*-*-14-*-*-*-*-*-gbk-*",
    de_substyle("active-selected", {
        shadow_colour = "orange",
        highlight_colour = "orange",
        -- background_colour = "#aaaa9e",
        background_colour = "black",
        foreground_colour = "orange",
    }),
    de_substyle("active-unselected", {
        shadow_colour = "white",
        highlight_colour = "white",
        background_colour = "black",
        foreground_colour = "white",
    }),
    de_substyle("inactive-selected", {
        shadow_colour = "white",
        highlight_colour = "white",
        background_colour = "black",
        foreground_colour = "white",
    }),
    de_substyle("inactive-unselected", {
        shadow_colour = "white",
        highlight_colour = "white",
        background_colour = "black",
        foreground_colour = "white",
    }),
    text_align = "center",
})

de_define_style("tab-frame", {
    based_on = "tab",
    de_substyle("*-*-*-*-activity", {
        shadow_colour = "white",
        highlight_colour = "white",
        background_colour = "black",
        foreground_colour = "white",
    }),
})

de_define_style("tab-frame-ionframe", {
    based_on = "tab-frame",
    spacing = 1,
})

de_define_style("tab-menuentry", {
    based_on = "tab",
    font = "-*-wenquanyi bitmap song-*-*-*-*-15-*-*-*-*-*-gbk-*",
    text_align = "left",
})

de_define_style("tab-menuentry-big", {
    based_on = "tab-menuentry",
    padding_pixels = 7,
})

de_define_style("input", {
    based_on = "*",
    shadow_colour = "black",
    highlight_colour = "black",
    background_colour = "#454545",
    foreground_colour = "white",
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style = "elevated",
    de_substyle("*-cursor", {
        background_colour = "white",
        foreground_colour = "#454545",
    }),
    de_substyle("*-selection", {
        background_colour = "black",
        foreground_colour = "white",
    }),
})

gr_refresh()

