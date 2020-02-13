import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig(removeKeys, additionalKeys)
import XMonad.Hooks.DynamicLog(dynamicLogWithPP, ppOutput, ppOrder, ppCurrent, ppUrgent, ppVisible, ppHidden, ppHiddenNoWindows, ppTitle, ppWsSep, ppSep, xmobarPP, xmobarColor) --for xmobar
import XMonad.Util.Run(spawnPipe, hPutStrLn)
-- import XMonad.Actions.SpawnOn(spawnOn)
import XMonad.Util.SpawnOnce
import XMonad.ManageHook(composeAll)
import XMonad.StackSet(greedyView, view, shift)
import XMonad.Actions.Warp(warpToScreen)
import Data.Ratio((%))

main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ desktopConfig
    { terminal           = myTerminal
    , modMask            = mod4Mask -- Rebind Mod to the Windows key
    , startupHook        = myStartupHook
    , borderWidth        = 3
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , focusFollowsMouse  = myFocusFollowsMouse
    , workspaces         = myWorkspaces
    , logHook            = myLogHook wsbar
    , manageHook         = myManageHook <+> manageHook defaultConfig
    } `additionalKeys` myKeys

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

-- Workspaces
terminalWs = "terminal"
chat = "chat"
web = "web"
emacs = "emacs"

myWorkspaces = [terminalWs, emacs, "3", "4", "5", "6", "7", "8", web, chat]

myStartupHook :: X ()
myStartupHook = do
  spawn "~/.screenlayout/office3.sh"
  spawn "feh --bg-scale ~/Pictures/Wallpapers/arch-linux.png"
  spawn "albert"
  spawnOnOnce terminalWs "urxvt"
  -- spawnOnOnce chat "Idobata"
  -- spawnOnOnce chat "slack"
  -- spawnOnOnce web "google-chrome-stable"
  -- spawnOnOnce emacs "emacs"

myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "Urxvt"                --> doShift terminalWs
  , className =? "google-chrome-stable" --> doShift web
  , className =? "slack"                --> doShift chat
  , className =? "emacs"                --> doShift emacs
  ]


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

-- KeyBindings

myKeys =
  [ ((0, 0x1008ff13), spawn "amixer -D default set PCM 5%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
  , ((0, 0x1008ff11), spawn "amixer -D default set PCM 5%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
  , ((0, 0x1008ff12), spawn "amixer -D default set PCM toggle")
  , ((0, 0x1008FF02), spawn "xbacklight + 10")
  , ((0, 0x1008FF03), spawn "xbacklight - 10")
  ] ++
  [((0 .|. mod4Mask, k), (selectScreenByWorkSpaceId i) >>  (windows $ greedyView i) >> (warpToWorkSpace i))
    | (i, k) <- zip myWorkspaces $ [xK_1 .. xK_9] ++ [xK_0]]
  ++
  [((shiftMask .|. mod4Mask, k), windows $ shift i)
    | (i, k) <- zip myWorkspaces $ [xK_1 .. xK_9] ++ [xK_0]]


selectScreenByWorkSpaceId :: WorkspaceId -> X ()
selectScreenByWorkSpaceId "chat" = selectScreen 1
selectScreenByWorkSpaceId "web" = selectScreen 2
selectScreenByWorkSpaceId _ = selectScreen 0

selectScreen ::ScreenId -> X ()
selectScreen scid = screenWorkspace scid >>= flip whenJust (windows . view)

warpToWorkSpace :: WorkspaceId -> X ()
warpToWorkSpace "chat" = warpToScreen 1 (1%2) (1%2)
warpToWorkSpace "web" = warpToScreen 2 (1%2) (1%2)
warpToWorkSpace _ = warpToScreen 0 (1%2) (1%2)
