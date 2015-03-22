-- This file was created by and is modified by Ion.

initialise_screen_id(0, {
    type = "WScreen",
    name = "WScreen",
    subs = {
        {
            type = "WIonWS",
            name = "read",
            split_tree = {
                split_dir = "horizontal",
                split_tls = 665, split_brs = 775,
                tl = {
                    split_dir = "vertical",
                    split_tls = 741, split_brs = 159,
                    tl = {
                        type = "WIonFrame",
                        name = "WIonFrame<1>",
                        flags = 24,
                        saved_y = 0, saved_h = 687,
                        saved_x = 0, saved_w = 720,
                        subs = {
                            {
                                type = "WClientWin",
                                windowid = 12582927,
                                checkcode = 1,
                                switchto = true,
                            },
                            {
                                type = "WClientWin",
                                windowid = 25165855,
                                checkcode = 2,
                            },
                        },
                    },
                    br = {
                        split_dir = "horizontal",
                        split_tls = 336, split_brs = 329,
                        tl = {
                            type = "WIonFrame",
                            name = "WIonFrame<3>",
                            flags = 24,
                            saved_y = 687, saved_h = 213,
                            saved_x = 0, saved_w = 271,
                            subs = {
                                {
                                    type = "WClientWin",
                                    windowid = 10485762,
                                    checkcode = 3,
                                    switchto = true,
                                },
                            },
                        },
                        br = {
                            type = "WIonFrame",
                            name = "WIonFrame",
                            flags = 24,
                            saved_y = 687, saved_h = 213,
                            saved_x = 336, saved_w = 384,
                            subs = {
                                {
                                    type = "WClientWin",
                                    windowid = 20971552,
                                    checkcode = 4,
                                    switchto = true,
                                },
                            },
                        },
                    },
                },
                br = {
                    type = "WIonFrame",
                    name = "WIonFrame<2>",
                    flags = 24,
                    saved_y = 0, saved_h = 760,
                    saved_x = 720, saved_w = 720,
                    subs = {
                        {
                            type = "WClientWin",
                            windowid = 14680130,
                            checkcode = 5,
                        },
                        {
                            type = "WClientWin",
                            windowid = 16777248,
                            checkcode = 6,
                        },
                        {
                            type = "WClientWin",
                            windowid = 23068675,
                            checkcode = 7,
                            switchto = true,
                        },
                    },
                },
            },
            switchto = true,
        },
    },
})

