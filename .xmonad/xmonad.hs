import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog

main = do
  xmobar myConfig >>= xmonad

myConfig = desktopConfig
  { terminal = myTerminal
  , modMask = mod4Mask -- Rebind Mod to the Windows key
  , startupHook = myStartupHook
  }

myTerminal = "urxvt"
myStartupHook = do
  spawn "~/.screenlayout/private3.sh"
  spawn "feh --bg-scale ~/Pictures/Wallpapers/arch-linux.jpg"
  spawn "albert"
