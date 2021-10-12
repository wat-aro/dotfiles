import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig (removeKeys, additionalKeys, additionalKeysP)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, ppOutput, ppOrder, ppCurrent, ppUrgent, ppVisible, ppHidden, ppHiddenNoWindows, ppTitle, ppWsSep, ppSep, xmobarPP, xmobarColor) --for xmobar
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Util.Run (spawnPipe, hPutStrLn)
-- import XMonad.Actions.SpawnOn(spawnOn)
import XMonad.Util.SpawnOnce
import XMonad.ManageHook (composeAll, doFloat)
import XMonad.Hooks.ManageHelpers (isDialog, doFullFloat)
import qualified XMonad.StackSet as W
import XMonad.Actions.Warp (warpToScreen)
import Data.Ratio ((%))
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Util.SpawnOnce (spawnOnce, spawnOnOnce)
import XMonad.Actions.SpawnOn (manageSpawn)
import XMonad.Layout.ThreeColumns

main = do
  wsbars <- mapM (\scid -> spawnPipe (myWsBar scid)) [0, 1]
  xmonad $ desktopConfig
    { terminal           = myTerminal
    , modMask            = mod4Mask -- Rebind Mod to the Windows key
    , startupHook        = myStartupHook
    , borderWidth        = 3
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , focusFollowsMouse  = myFocusFollowsMouse
    , workspaces         = myWorkspaces
    , logHook            = myLogHooks wsbars
    , manageHook         = myManageHook <+> manageSpawn <+> myManageFloat <+> manageHook defaultConfig
    , layoutHook         = myLayout
    } `additionalKeys`
    [
      ((0 .|. mod4Mask, k), (selectScreenByWorkSpaceId i) >> (windows $ W.greedyView i) >> (warpToWorkSpace i))
        | (i, k) <- zip myWorkspaces $ [xK_1 .. xK_9] ++ [xK_0]
    ]
    `additionalKeys`
    [
      ((shiftMask .|. mod4Mask, k), windows $ W.shift i)
        | (i, k) <- zip myWorkspaces $ [xK_1 .. xK_9] ++ [xK_0]
    ]
    `additionalKeys`
    [
      ((0, 0x1008ff13), spawn "pactl set-sink-volume `pactl list sinks short | grep RUNNING | awk '{print $1}'` +5% && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
    , ((0, 0x1008ff11), spawn "pactl set-sink-volume `pactl list sinks short | grep RUNNING | awk '{print $1}'` -5% && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
    , ((0, 0x1008ff12), spawn "pactl set-sink-mute `pactl list sinks short | grep RUNNING | awk '{print $1}'` toggle")
    , ((0, 0x1008FF02), spawn "xbacklight + 10")
    , ((0, 0x1008FF03), spawn "xbacklight - 10")
    ]
    `additionalKeysP`
    [
      ("M-c", kill)
    , ("M-f", withFocused $ windows . (\a -> W.float a (W.RationalRect 0 0 1 1)))
    , ("M-s", spawn "xscreensaver-command -lock")
    ]

myTerminal = "urxvtc -e bash -c 'tmux -q has-session && exec tmux attach-session || exec tmux new-session -n$USER -s$USER@$HOSTNAME'"
myFocusFollowsMouse = False

myLayout = avoidStruts $ onWorkspace chat (Tall 1 (3/100) (7/10)) $ layoutHook desktopConfig
-- myLayout = avoidStruts $ onWorkspace chat (ThreeCol 1 (3/100) (1/3) ||| ThreeColMid 1 (3/100) (1/3)) $ layoutHook desktopConfig

colorBlue      = "#857da9"
colorGreen     = "#88b986"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#000000"

-- Workspaces
terminalWs = "terminal"
chat = "chat"
web = "web"
emacs = "emacs"
vscode = "vscode"

myWorkspaces = [terminalWs, emacs, vscode, "4", "5", "6", "7", "8", web, chat]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "~/.screenlayout/private3.sh"
  spawnOnce "albert"
  spawnOnce "xscreensaver -no-splash"
  spawnOnOnce terminalWs myTerminal
  spawnOnOnce web "google-chrome-stable"
  spawnOnOnce emacs "emacs"
  spawnOnce "google-chrome-stable --app=https://idobata.io"
  spawnOnce "slack"
  (selectScreenByWorkSpaceId web) >> (windows $ W.greedyView web)
  (selectScreenByWorkSpaceId chat) >> (windows $ W.greedyView chat)
  (selectScreenByWorkSpaceId terminalWs) >> (windows $ W.greedyView terminalWs)
  spawnOnce "feh --bg-scale ~/Pictures/Wallpapers/wallpaper.jpg"

myManageHook :: ManageHook
myManageHook = composeAll
  [ appName   =? "idobata.io" --> doShift chat
  , className =? "Slack"         --> doShift chat
  ]

myManageFloat :: ManageHook
myManageFloat = composeAll
  [ appName =? "google-chrome" <&&> resource =? "Dialog" --> doFloat
  ]

myLogHooks hs = mapM_ myLogHook hs
myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar scid = "xmobar ~/.xmonad/xmobarrc -x " ++ show scid

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

selectScreenByWorkSpaceId :: WorkspaceId -> X ()
selectScreenByWorkSpaceId "chat" = selectScreen 1
selectScreenByWorkSpaceId "web" = selectScreen 2
selectScreenByWorkSpaceId _ = selectScreen 0

selectScreen ::ScreenId -> X ()
selectScreen scid = screenWorkspace scid >>= flip whenJust (windows . W.view)

warpToWorkSpace :: WorkspaceId -> X ()
warpToWorkSpace "chat" = warpToScreen 1 (1%2) (1%2)
warpToWorkSpace "web" = warpToScreen 2 (1%2) (1%2)
warpToWorkSpace _ = warpToScreen 0 (1%2) (1%2)
