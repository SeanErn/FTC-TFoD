import os
import sys
from colorama import Fore, Back, Style

def print_help():
    print(Fore.RED+"Usage: python script_name.py <directory> <old_string> <new_string>")
    print(Fore.RESET+"This script will loop through all the .txt files in the specified directory,")
    print("open each one, find all occurrences of the old string, replace it with the new string,")
    print("and write the updated contents back to the file.")

# If there are not enough arguments, print the help message
if len(sys.argv) < 4:
    print_help()
else:
    # The directory containing the txt files
    directory = sys.argv[1]

    # The string to find and replace
    old_str = sys.argv[2]
    new_str = sys.argv[3]

    # Loop through each file in the directory
    for filename in os.listdir(directory):
        if filename.endswith('.txt'):
            # Open the file
            with open(os.path.join(directory, filename), 'r') as file:
                # Read the contents of the file
                file_contents = file.read()

            # Replace the old string with the new string
            new_contents = file_contents.replace(old_str, new_str)

            # Write the new contents to the file
            with open(os.path.join(directory, filename), 'w') as file:
                file.write(new_contents)
