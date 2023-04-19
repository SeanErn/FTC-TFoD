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

#### See the [*Quick start*](https://github.com/SeanErn/FTC-TFoD-Easy/wiki/quickstart) guide for full tutorials
