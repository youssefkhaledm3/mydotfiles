-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	-- hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("xhost +si:localuser:root")

	--   hl.exec_cmd("nm-applet")
	--   hl.exec_cmd("waybar & hyprpaper & firefox")
end)
