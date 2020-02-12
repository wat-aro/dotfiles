import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig -- removeKeys, addtionalKeys

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
  } `additionalKeys`
  [ ((0, 0x1008ff13), spawn "amixer -D default set PCM 5%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
  , ((0, 0x1008ff11), spawn "amixer -D default set PCM 5%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
  , ((0, 0x1008ff12), spawn "amixer -D default set PCM toggle")
  , ((0, 0x1008FF02), spawn "xbacklight + 10")
  , ((0, 0x1008FF03), spawn "xbacklight - 10")
  ]

myTerminal = "urxvt"
myFocusFollowsMouse = False

myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#dddddd"

myWorkspaces = ["terminal", "chat", "web", "emacs", "5", "6", "7", "8", "9"]

myStartupHook = do
  spawn "~/.screenlayout/office3.sh"
  spawn "feh --bg-scale ~/Pictures/Wallpapers/arch-linux.png"
  spawn "albert"
