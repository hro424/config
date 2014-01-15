import XMonad
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Scratchpad
import qualified XMonad.StackSet as W
import System.IO

myLogHook dest = dynamicLogWithPP defaultPP
    { ppOutput = hPutStrLn dest
    , ppTitle = xmobarColor "green" "" . shorten 50
    }

myLayoutHook = avoidStruts $ layoutHook defaultConfig

myManageHook = composeAll
    [ className =? "Gvim" --> doCenterFloat
    , role =? "Preferences" --> doFloat
    , className =? "Nautilus" --> doCenterFloat
    , className =? "Gnome-calculator" --> doFloat
    , manageDocks
    ] where role = stringProperty "WM_WINDOW_ROLE"

vimScratchpads =
    [ NS "gvim" "gvim" (className =? "Gvim") doCenterFloat
    ]

conkyScratchpads =
    [ NS "conky" "conky" (className =? "Conky") doCenterFloat
    ]

nautilusScratchpads =
    [ NS "nautilus" "nautilus" (className =? "Nautilus") doCenterFloat
    ]

terminalScratchpads =
    [ NS "xfce4-terminal" "xfce4-terminal" (className =? "Xfce4-terminal") doCenterFloat
    ]

myTerminal = "xfce4-terminal"

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , layoutHook = myLayoutHook
        , manageHook = myManageHook
            <+> manageHook defaultConfig
            <+> namedScratchpadManageHook vimScratchpads
            <+> namedScratchpadManageHook nautilusScratchpads
            <+> scratchpadManageHook
            (W.RationalRect (1/4) (1/40) (1/2) (3/4))
            , logHook = myLogHook xmproc
            , terminal = myTerminal
        } `additionalKeysP`
        [ ("M-s", goToSelected defaultGSConfig)
        , ("M-o", scratchpadSpawnActionTerminal "urxvt")
        , ("M-e", namedScratchpadAction vimScratchpads "gvim")
        , ("M-t", namedScratchpadAction nautilusScratchpads "nautilus")
        ]

