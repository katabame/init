#!/bin/bash
set -e

# Install Rectangle
# brew install --cask rectangle

# Configure application setting
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -int 1
defaults write com.knollsoft.Rectangle SUHasLaunchedBefore -int 1
defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -int 1
defaults write com.knollsoft.Rectangle hideMenubarIcon -int 1
defaults write com.knollsoft.Rectangle launchOnLogin -int 1


# Configure keyboard shortcuts

# ⌃⌥⇧⌘ ←
defaults write com.knollsoft.Rectangle leftHalf -dict-add keyCode -float 123 modifierFlags -float 1966080
# ⌃⌥⇧⌘ →
defaults write com.knollsoft.Rectangle rightHalf -dict-add keyCode -float 124 modifierFlags -float 1966080
# ⌃⌥⇧⌘ ↓
defaults write com.knollsoft.Rectangle restore -dict-add keyCode -float 125 modifierFlags -float 1966080
# ⌃⌥⇧⌘ ↑
defaults write com.knollsoft.Rectangle maximize -dict-add keyCode -float 126 modifierFlags -float 1966080

defaults write com.knollsoft.Rectangle maximize -dict-add keyCode -float 126 modifierFlags -float 1966080

# I don't need those 'cuz I wanna be minimalist
defaults write com.knollsoft.Rectangle bottomHalf -dict-add
defaults write com.knollsoft.Rectangle bottomLeft -dict-add
defaults write com.knollsoft.Rectangle bottomRight -dict-add
defaults write com.knollsoft.Rectangle center -dict-add
defaults write com.knollsoft.Rectangle centerThird -dict-add
defaults write com.knollsoft.Rectangle firstThird -dict-add
defaults write com.knollsoft.Rectangle firstTwoThirds -dict-add
defaults write com.knollsoft.Rectangle larger -dict-add
defaults write com.knollsoft.Rectangle lastThird -dict-add
defaults write com.knollsoft.Rectangle lastTwoThirds -dict-add
defaults write com.knollsoft.Rectangle maximizeHeight -dict-add
defaults write com.knollsoft.Rectangle nextDisplay -dict-add
defaults write com.knollsoft.Rectangle previousDisplay -dict-add
defaults write com.knollsoft.Rectangle reflowTodo -dict-add
defaults write com.knollsoft.Rectangle smaller -dict-add
defaults write com.knollsoft.Rectangle toggleTodo -dict-add
defaults write com.knollsoft.Rectangle topHalf -dict-add
defaults write com.knollsoft.Rectangle topLeft -dict-add
defaults write com.knollsoft.Rectangle topRight -dict-add
