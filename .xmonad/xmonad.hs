import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog

main = do
  xmobar myConfig >>= xmonad

myConfig = desktopConfig
  { terminal = myTerminal
  , modMask = mod4Mask -- Rebind Mod to the Windows key
  , startupHook = myStartupHook
  , borderWidth = 3
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , focusFollowsMouse = myFocusFollowsMouse
  , workspaces = myWorkspaces
  }

myTerminal = "urxvt"
myFocusFollowsMouse = False

myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#dddddd"

myWorkspaces = ["terminal", "chat", "web", "emacs", "5", "6", "7", "8", "9"]

myStartupHook = do
  spawn "~/.screenlayout/office3.sh"
  spawn "feh --bg-scale ~/Pictures/Wallpapers/arch-linux.png"
  spawn "albert"
