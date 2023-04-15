import os
import pathlib

# Install colorama
print('Installing colorama...')
os.system('pip install colorama')
from colorama import Fore
print(Fore.GREEN+'[SUCCESS] Colorama installed successfully!')

# Check if user has git apt package installed
if not pathlib.Path('/usr/bin/git').exists():
    print('Installing git...')
    os.system('apt-get update -y')
    os.system('apt-get install git -y')
else:
    print(Fore.YELLOW+'[INFO] Git already installed, skipping...')

# Check if user has protobuf apt package installed
if not pathlib.Path('/usr/bin/protoc').exists():
    print(Fore.CYAN+'[INSTALL] Installing protobuf...')
    os.system('apt-get update -y')
    os.system('apt-get install protobuf-compiler -y')
else:
    print(Fore.YELLOW+'[INFO] Protobuf already installed, skipping...')

# Check if user has wget apt package installed
if not pathlib.Path('/usr/bin/wget').exists():
    print(Fore.CYAN+'[INSTALL] Installing wget...')
    os.system('apt-get update -y')
    os.system('apt-get install wget -y')
else:
    print(Fore.YELLOW+'[INFO] Wget already installed, skipping...')

# Clone the tensorflow models repository if it doesn't already exist
if "modelsLib" in pathlib.Path.cwd().parts:
    while "modelsLib" in pathlib.Path.cwd().parts:
        os.chdir('..')
elif not pathlib.Path('modelsLib').exists():
    os.system('git clone --depth 1 https://github.com/tensorflow/models modelsLib')
else:
    print(Fore.YELLOW+'[INFO] Tensorflow models already exists, skipping...')

# Install the object detection API
os.chdir('modelsLib/research')
os.system('protoc object_detection/protos/*.proto --python_out=.')

# If setup.py is not present, copy it from the tensorflow object detection API
if not pathlib.Path('setup.py').exists():
    os.system('cp object_detection/packages/tf2/setup.py .')
else:
    print(Fore.YELLOW+'[INFO] Setup.py already exists, skipping...')

# directory slim/deployment is missing in models/research, run the build install script
print(Fore.YELLOW+'[INFO] Installing object detection API...')
print(Fore.WHITE+'[INFO] This may take a while...')
os.system('python -m pip install .')
print(Fore.GREEN+'[SUCCESS] Object detection API installed successfully!')

# Run the build test script
# print(Fore.LIGHTBLUE_EX+'[TEST] Running build test script...')
# os.system('python object_detection/builders/model_builder_tf2_test.py')

print(Fore.GREEN+'[SUCCESS] Installed Correctly!')

