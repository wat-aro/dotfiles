import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig(removeKeys, additionalKeys)
import XMonad.Hooks.DynamicLog(dynamicLogWithPP, ppOutput, ppOrder, ppCurrent, ppUrgent, ppVisible, ppHidden, ppHiddenNoWindows, ppTitle, ppWsSep, ppSep, xmobarPP, xmobarColor) --for xmobar
import XMonad.Util.Run(spawnPipe, hPutStrLn)

main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ desktopConfig
    { terminal = myTerminal
    , modMask = mod4Mask -- Rebind Mod to the Windows key
    , startupHook = myStartupHook
    , borderWidth = 3
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , focusFollowsMouse = myFocusFollowsMouse
    , workspaces = myWorkspaces
    , logHook = myLogHook wsbar
    } `additionalKeys`
    [ ((0, 0x1008ff13), spawn "amixer -D default set PCM 5%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
    , ((0, 0x1008ff11), spawn "amixer -D default set PCM 5%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
    , ((0, 0x1008ff12), spawn "amixer -D default set PCM toggle")
    , ((0, 0x1008FF02), spawn "xbacklight + 10")
    , ((0, 0x1008FF03), spawn "xbacklight - 10")
    ]

myTerminal = "urxvt"
myFocusFollowsMouse = False

colorBlue      = "#857da9"
colorGreen     = "#88b986"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#dddddd"

myWorkspaces = ["terminal", "chat", "web", "emacs", "5", "6", "7", "8", "9"]

myStartupHook = do
  spawn "~/.screenlayout/office3.sh"
  spawn "feh --bg-scale ~/Pictures/Wallpapers/arch-linux.png"
  spawn "albert"

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar ~/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_) -> [ws,t]
                , ppCurrent         = xmobarColor colorGreen colorNormalbg
                , ppUrgent          = xmobarColor colorWhite colorNormalbg
                , ppVisible         = xmobarColor colorWhite colorNormalbg
                , ppHidden          = xmobarColor colorWhite colorNormalbg
                , ppHiddenNoWindows = xmobarColor colorGray  colorNormalbg
                , ppTitle           = xmobarColor colorWhite colorNormalbg
                , ppWsSep           = "    "
                , ppSep             = "  :::  "
                }
