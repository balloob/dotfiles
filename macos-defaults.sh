#!/usr/bin/env bash

# macOS System Preferences
# Run this script to configure macOS system settings

set -e

# Close any open System Settings panes to prevent overriding
# Note: App was renamed from "System Preferences" to "System Settings" in macOS Ventura (13)
osascript -e 'tell application "System Settings" to quit'

echo "Setting macOS defaults..."

###############################################################################
# Security & Quarantine                                                      #
###############################################################################

# Remove quarantine attribute from all applications
# This prevents the "Are you sure you want to open this application?" dialog
# Note: The LSQuarantine setting no longer works in modern macOS
echo "Removing quarantine from applications..."
find /Applications -maxdepth 3 -name "*.app" -print0 | xargs -0 -I {} xattr -dr com.apple.quarantine {} 2>/dev/null || true

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set trackpad scrolling speed (lower = slower, range: 0-3, default: ~0.6875)
# Setting to ~0.5 for about a third slower than default
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.6875

# Set mouse scrolling speed (lower = slower, range: 0-3, default: ~0.6875)
# Setting to ~0.5 for about a third slower than default
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 0.6875

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

###############################################################################
# Dock, Dashboard, and hot corners                                           #
###############################################################################

# Set the icon size of Dock items (your current: 17, recommended: 48)
# Uncomment your preference:
defaults write com.apple.dock tilesize -int 55
# defaults write com.apple.dock tilesize -int 17  # Your current small size

# Position Dock on screen (your current: right)
# Options: "left", "bottom", "right"
defaults write com.apple.dock orientation -string "bottom"

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool false

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
# NOTE: This setting has reduced effectiveness in macOS Ventura (13) and later
# Apple has moved more animations to be system-controlled
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Auto-hiding Dock delay (your current: 1 second, recommended: instant)
# Uncomment your preference:
defaults write com.apple.dock autohide-delay -float 0
# defaults write com.apple.dock autohide-delay -float 1  # Your current: 1 second delay

# Auto-hiding Dock animation speed (your current: 0.6s)
defaults write com.apple.dock autohide-time-modifier -float 0.6

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable magnification
defaults write com.apple.dock magnification -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry in Terminal.app
defaults write com.apple.terminal SecureKeyboardEntry -bool true

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Screenshots                                                                 #
###############################################################################

# Save screenshots to the desktop
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Screenshot capture mode (your current: window selection)
# Options: "selection", "window", "screen"
defaults write com.apple.screencapture style -string "window"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# TextEdit                                                                    #
###############################################################################

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# Energy & Sleep Settings                                                     #
###############################################################################

# Set display sleep to 10 minutes
sudo pmset displaysleep 10

# Set computer sleep to 15 minutes (standard setting)
sudo pmset sleep 15

# Disable hard disk sleep to prevent external drives from blocking system sleep
# Set to 0 to keep drives awake and avoid ExternalMedia sleep prevention
sudo pmset disksleep 0

# Enable Power Nap (allows Time Machine backups and iCloud sync during sleep)
sudo pmset powernap 1

# Wake for network access (useful for remote access)
sudo pmset womp 1

###############################################################################
# Screen Saver & Lock Screen                                                  #
###############################################################################

# Start screen saver after 2 minutes of inactivity
defaults -currentHost write com.apple.screensaver idleTime -int 120

# Require password when screen saver starts
defaults write com.apple.screensaver askForPassword -int 1

# Require password immediately (no delay)
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Menu Bar Clock                                                              #
###############################################################################

# NOTE: Menu bar clock settings are now primarily managed through Control Center
# in macOS Ventura (13) and later. These settings may be partially or fully ignored.
# Configure via: System Settings → Control Center → Clock Options

# Show analog clock in menu bar
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Show 24h
defaults write com.apple.menuextra.clock Show24Hour -bool true

# Show day of week
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true

# Don't show date (day/month)
defaults write com.apple.menuextra.clock ShowDate -int 0

###############################################################################
# Kill affected applications                                                  #
###############################################################################

echo "Done. Note that some of these changes require a logout/restart to take effect."

# Restart affected applications
for app in "Activity Monitor" \
    "Dock" \
    "Finder" \
    "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
done
