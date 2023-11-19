#!/bin/bash

export GUM_CHOOSE_CURSOR_FOREGROUND="#FFA500"
export GUM_CHOOSE_PROMPT_FOREGROUND="#FFA500"

# Install Gum
if ! command -v gum &> /dev/null
then
    echo "Run installDependencies.sh before continuing!"
    exit
fi


# Project manager
function projectManager {
}

while true; do
    clear
    gum style --align left --width 50 --foreground "#FFA500" \
    'TensorFlow V2 Toolchain'
    gum style --align left --width 50 --foreground "#FFA500" \
    'Created by FRC team 5152'
    gum style --align left --width 50  --foreground "#FFFFFF" \
    '************************************'
    choice=$(gum choose "Install" "Switch Project" "Annotate" "Prepare Dataset" "Train Model" "Export Model" "Test Model" "Advanced" "Exit")
    case $choice in
        "Install")
            ./install.sh
            ;;
        "Project Manager")