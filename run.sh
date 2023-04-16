#!/bin/bash

if ! command -v gum &> /dev/null
then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update
    sudo apt install gum
    sleep 3 # wait for Gum to install and configure
fi

export GUM_CHOOSE_CURSOR_FOREGROUND="#FFA500"
export GUM_CHOOSE_PROMPT_FOREGROUND="#FFA500"

while true; do
    clear
    gum style --align left --width 50 --foreground "#FFA500" \
    'TENSORFLOW For FTC'
    gum style --align left --width 50 --foreground "#FFA500" \
    'Updated by: FRC Team 5152'
    gum style --align left --width 50  --foreground "#FFFFFF" \
    '************************************'
    choice=$(gum choose "Install" "Manual Label" "Semi Automatic Label" "Rename Labels" "Convert Labels" "Train Model" "Export Model" "Test Model" "Advanced" "Exit")
    case $choice in
        "Install")
            if ! command -v python3 &> /dev/null
            then
                echo "Python3 is not installed. Please install Python3 and try again."
                read -p "Press enter to continue..."
            else
                # run your installation script here
                python install.py
                read -p "DONE! Press enter to continue..."
            fi
            ;;
        "Manual Label")
            filename=$(gum input --placeholder "Enter the path of the video to label")
            frames=$(gum input --placeholder "Enter the number of frames to skip between each label")
            echo "Manual labeling with filename $filename and frames=$frames"
            echo "
Normal Mode Keybinds:

SpaceBar: Toggle autoplay (step through frames without pausing to label)
j:        Cut autoplay delay in half
k:        Double autoplay delay
n:        Go to the next frame which will be saved, and pause to label
h:        Step backward one frame
l:        Step forward one frame
q:        Quit the labeler

Label Mode Keybinds:

(backtick) + [a-z]: Set [a-z] as the current class
c:             Clear all bounding boxes
x:             Clear the most recent bounding box
r:             Load the last set of bounding boxes
Mouse:         Draw bounding boxes"
                python labeler.py $filename -f $frames
            ;;
        "Semi Automatic Label")
            choiceSemi=$(gum choose "Find Bounding (FIRST)" "Track Bounding (SECOND)" "Exit")
            case $choiceSemi in
                "Find Bounding (FIRST)")
                    filename=$(gum input --placeholder "Enter the path of the video to label")
                    echo "
Normal Mode Keybinds:

q:        Quit the labeler

Label Mode Keybinds:

Any key (A-Z): Set [A-Z] as the current class
Mouse:         Draw bounding boxes"
                        python find_bb.py $filename
                    ;;
                "Track Bounding (SECOND)")
                    filename=$(gum input --placeholder "Enter the path of the video to label")
                    echo "
Normal Mode Keybinds:

q:        Quit the tracker"
                        python tracking.py $filename
                    ;;
                "Exit")
                    echo "Exiting..."
                    exit 0
                    ;;
                *)
                    echo "Invalid option. Please try again."
                    read -p "Press enter to continue..."
                    ;;
            esac
            ;;
        "Rename Labels")
            dir=$(gum input --placeholder "Enter the path of the directory containing the label files")
            old_label=$(gum input --placeholder "Enter the old label letter")
            new_label=$(gum input --placeholder "Enter the new label string")
            echo "Renaming labels in directory $dir from $old_label to $new_label"
            python rename_labels.py $dir $old_label $new_label
            read -p "DONE! Press enter to continue..."
            ;;
        "Convert Labels")
            dir=$(gum input --placeholder "Enter the path of the directory containing the training data (Ex. train_data)")
            number=$(gum input --placeholder "Enter the number of files to split data into (used if you want to train on multiple machines)")
            split=$(gum input --placeholder "Percentage split of training to validation data (0.0-1.0)")
            echo "Converting labels in directory $dir"
            python convert_labels_to_records.py $dir -n $number -s $split
            read -p "DONE! Press enter to continue..."
            ;;
        "Train Model")
            # run your script for "Train Model" here
            python config_pipeline.py
            chmod +x ./scripts/train.sh
            xdg-open http://localhost:6006
            ./scripts/train.sh & x-terminal-emulator -e tensorboard --logdir=models/ssd_mobilenet_v2_quantized/saved_model && fg
            ;;
        "Export Model")
            # run your script for "Train Model" here
            chmod +x ./scripts/export_tflite.sh
            ./scripts/export_tflite.sh
            ;;
        "Test Model")
            # run your script for "Test Model" here
            echo "Test Model script not implemented."
            read -p "Press enter to continue..."
            ;;
        "Advanced")
            # run your script for "Advanced" here
            choiceAdvanced=$(gum choose "Purge models" "Purge dataset" "Exit")
            case $choiceAdvanced in
                "Purge models")
                    confirm=$(gum input --placeholder "Type PURGE to confirm purging of models")
                    if [ "$confirm" == "PURGE" ]; then
                        rm -rf models/ssd_mobilenet_v2_quantized/saved_model
                        read -p "Purged models! Press enter to continue..."
                    else
                        read -p "Purge cancelled. Press enter to continue..."
                    fi
                    ;;
                "Purge dataset")
                    confirm=$(gum input --placeholder "Type PURGE to confirm purging of dataset")
                    if [ "$confirm" == "PURGE" ]; then
                        rm -rf train_data/*
                        read -p "Purged dataset! Press enter to continue..."
                    else
                        read -p "Purge cancelled. Press enter to continue..."
                    fi
                    ;;
                "Exit")
                    echo "Exiting..."
                    exit 0
                    ;;
                *)
                    echo "Invalid option. Please try again."
                    read -p "Press enter to continue..."
                    ;;
            esac
            ;;
        "Exit")
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            read -p "Press enter to continue..."
            ;;
    esac
done
