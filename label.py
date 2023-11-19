import numpy as np
import cv2
import argparse
import sys

DESCRIPTION = "Parses the metadata from a given tflite and exports it as JSON"
WINDOW_TITLE = "Labeler | Ftc-Tfod-Easy "
parser = argparse.ArgumentParser(description=DESCRIPTION)
parser.add_argument("filename",
        help="path to video to label")
args = parser.parse_args()

def openVideo(path):
    cap = cv2.VideoCapture(path)
    if not cap.isOpened():
        sys.exit("Failed to open video! Is the path correct? (Exiting...)")
    return cap
        


