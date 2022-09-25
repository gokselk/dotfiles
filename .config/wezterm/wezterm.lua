local wezterm = require "wezterm"

return {
    color_scheme = "Molokai",
    font = wezterm.font("Hack"),
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    ssh_domains = {
        {
            name = 'ceng',
            remote_address = 'login.ceng.metu.edu.tr:8085',
            remote_wezterm_path = "/home/bs02/e2395952/wezterm/AppRun",
            username = 'e2395952',
        }
    },
}
