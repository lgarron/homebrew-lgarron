do shell script "if [[ \"scale = 2.0\" = $(/Applications/RDM.app/Contents/MacOS/SetResX -ld | grep -o \"scale = \\d\\.\\d\") ]]; then NEW_RES=\"1.0\"; else NEW_RES=\"2.0\"; fi && /Applications/RDM.app/Contents/MacOS/SetResX -s $NEW_RES"