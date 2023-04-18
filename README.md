## FTC TFoD Easy

### Credits:
Credits to [ssysm](github.com/ssysm) for creating the original framework

***
### Preface:
This framework is designed so teams are able to train fully fledged tensorflow models on local machines instead of using FIRST's ftcml in the cloud. This is only helpful if a member has a powerful enough pc with a GPU. Otherwise I recommend that you use ftcml instead. This program has been updated to make the user experience much better. With that said, it still will require at least some technical know-how as problems will arise.


### Requirements:
- Python 3.7
- Ubuntu-based OS (Windows is not supported at this time. Other linux distros may work, but they need to be able to run the `apt` package manager)
- A GPU with CUDA support (Nvidia GPUs are recommended)
- Training and Validation videos

### Installation:
1. Clone this repository
```bash
git clone https://github.com/SeanErn/FTC-TFoD-Easy.git
```
2. Enter the directory
```bash
cd FTC-TFoD-Easy
```
3. Install the required packages
```bash
./run.sh
```
![InstallCmd](.readmePics/InstallCmd.png "InstallCmd")

And that's it! You're ready to start training your own models!

### Getting Training Data:
Things to remember:
- Record the object from different angles and distances
- Record the object in different lighting conditions
- Record the object in different backgrounds
- Record around 900 frames per object MINIMUM (30s of video at 30fps)
- Record using the camera you will be using on the robot

**An example of this for the 2023 season might be:<br>**
1. Mount your camera to the robot in its final position
2. Connect the USB cable to a laptop or other device
3. Open up any video recording software (such as camera on windows)
4. Select the camera you will be using on the robot
5. Record the object from different angles, distances, and lighting conditions by moving the robot around for 30 seconds, while still keeping the object in frame
6. Repeat step 5 for each object you want to detect

### Labeling Data:
1. Place your training videos in the `train_data` folder
2. Run the main script
```bash
./run.sh
```

#### Option 1: Labeling each frame manually
1. Select `Manual Label` from the menu
![ManualLabel](.readmePics/ManualLabel.png "ManualLabel")
2. Copy the path to the video you want to label and paste it into the prompt (Ex. `train_data/2023.mp4`)
![EnterPath](.readmePics/EnterPath.png "EnterPath")
3. Enter the amount of frames you want to skip between each frame you label (useful only if your video is very long) If you want to label every frame, enter 0
![EnterSkip](.readmePics/EnterSkip.png "EnterSkip")
4. Press the `Backtick key` and any letter on your keyboard to set a label for that frame
5. Click on the upper left corner of your object to set the top left corner of the bounding box and click on the lower right corner of your object to set the bottom right corner of the bounding box (the program should look something like this)
![LabelManualProgramBox](.readmePics/LabelManualProgramBox.png "LabelManualProgramBox")
6. Press `l` to move to the next frame
7. Repeat steps 4-6 until you have labeled all frames
8. Press `q` to quit the program
9. Repeat steps 1-8 for each video you want to label

#### Option 2: Labeling frames with OpenCV
1. Select `Semi Automatic Label` from the menu
![semiAutoLabel](.readmePics/semiAutoLabel.png "semiAutoLabel")
2. Select `Find Bounding (FIRST)` from the submenu
![semiAutoLabelSubmenuFindBounding](.readmePics/semiAutoLabelSubmenuFindBounding.png "semiAutoLabelSubmenuFindBounding")
3. Copy the path to the video you want to label and paste it into the prompt (Ex. `train_data/2023.mp4`)
![EnterPath](.readmePics/EnterPath.png "EnterPath")
4. Press any letter on your keyboard to set a label for that frame
5. Click on the upper left corner of your object to set the top left corner of the bounding box and click on the lower right corner of your object to set the bottom right corner of the bounding box (the program should look something like this)
![LabelSemiFindBoxes](.readmePics/LabelSemiFindBoxes.png "LabelSemiFindBoxes")
6. Press `q` to quit the program
7. Select `Semi Automatic Label` from the menu
![semiAutoLabel](.readmePics/semiAutoLabel.png "semiAutoLabel")
8. Select `Track Bounding (SECOND)` from the submenu
![semiAutoLabelSubmenuTrackBounding](.readmePics/semiAutoLabelSubmenuTrackBounding.png "semiAutoLabelSubmenuTrackBounding")
9. Copy the path to the video you want to label and paste it into the prompt (Ex. `train_data/2023.mp4`)
![EnterPath](.readmePics/EnterPath.png "EnterPath")
10. Check to make sure the bounding box looks correct
![LabelSemiTrackBoxesConfirm](.readmePics/LabelSemiTrackBoxesConfirm.png "LabelSemiTrackBoxesConfirm")
11. Press `y` if the bounding box is correct, or `n` if it is not
12. The program will then track the object in the video and label each frame. If the bounding box ever looks incorrect, press the `spacebar` to pause the video. Use the dots to adjust the bounding box. Then press `spacebar` again to continue the video
![LabelSemiTrackBoxesEdit](.readmePics/LabelSemiTrackBoxesEdit.png "LabelSemiTrackBoxesEdit")
13. Press `q` to quit the program manually, or wait for the video to finish and it will quit automatically
14. Repeat steps 1-13 for each video you want to label

### Editing Label Names:
1. Select `Rename Labels` from the menu
![RenameLabels](.readmePics/RenameLabels.png "RenameLabels")
2. Enter the path of the directory containing the raw label files and images (Ex. `train_data/2023_TrackerCSRT_1.000000`)
![EnterPathWithRawLabelFiles](.readmePics/EnterPathWithRawLabelFiles.png "EnterPathWithRawLabelFiles")
3. Enter the old letter used to represent the label (Ex. `p`)
![EnterOldLetter](.readmePics/EnterOldLetter.png "EnterOldLetter")
4. Enter the new string you want to use to represent the label (Ex. `Paw`)
![EnterNewString](.readmePics/EnterNewString.png "EnterNewString")
5. Repeat steps 1-4 for each label you want to rename

### Converting Label Files for Training:
1. Select `Convert Labels` from the menu
![ConvertLabels](.readmePics/ConvertLabels.png "ConvertLabels")
2. Enter the path of the directory containing the training data (Ex. `train_data`)
![EnterPathWithTrainingData](.readmePics/EnterPathWithTrainingData.png "EnterPathWithTrainingData")
3. Enter the number of files you want to split the training data into (Ex. `1`) (This is useful if you have a lot of training data and want to train on multiple computers at once)
![EnterNumFiles](.readmePics/EnterNumFiles.png "EnterNumFiles")
4. Enter the percentage of the training data you want to use for validation (Ex. `0.3` for `30%`) (This is so you can test your model on data it has never seen before)
![EnterPercentValidation](.readmePics/EnterPercentValidation.png "EnterPercentValidation")

### Training:
1. Select `Train Model` from the menu and the training will automatically start
![TrainModel](.readmePics/TrainModel.png "TrainModel")
2. Wait for the training to finish. This may take a while depending on the amount of training data you have and the power of your GPU
3. To view the training progress, open up a web browser and go to `http://localhost:6006/`
![Tensorboard](.readmePics/Tensorboard.png "Tensorboard")
4. Scroll down and expand the `loss` section
![Loss](.readmePics/Loss.png "Loss")<br>
The lower the loss, the better the model is performing. If the loss is not decreasing, you may need to add more training data or train for longer



