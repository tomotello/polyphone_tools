#!/bin/sh
# 
# Polyphone Soundfont Editor
# Post build tasks in a shell script
#
# Run the following command to include libraries and frameworks inside the bundle (adjust the path first!):

export QT_ROOT=/Volumes/Data/Qt/5.7
# set source directory, the directory where polyphone.pro is located
export POLYPHONE_SRC=/Volumes/Data/Dev/polyphone-1.7/trunk
# set  BUILD_TYPE DEBUG | RELEASE
export BUILD_TYPE=RELEASE

echo "Deploying qt dependencies ..."
"$QT_ROOT"/clang_64/bin/macdeployqt "$POLYPHONE_SRC"/"$BUILD_TYPE"/Polyphone.app
echo done
# Copy / paste the framework Jackmp from trunk/lib/mac to:
echo "Deploying Jack framework ... "
cp -rp "$POLYPHONE_SRC"/lib/mac/Jackmp.framework "$POLYPHONE_SRC"/"$BUILD_TYPE"/Polyphone.app/Contents/Frameworks
echo done


# Finally, run the following command in a single line
echo "Installing Jack Framework on system ..."
sudo install_name_tool -change /System/Library/Frameworks/Jackmp.framework/Versions/A/Jackmp @executable_path/../Frameworks/Jackmp.framework/Versions/A/Jackmp "$POLYPHONE_SRC"/RELEASE/Polyphone.app/Contents/MacOS/Polyphone 
echo done
echo "You can now start Polyphon by executing"
echo "$POLYPHONE_SRC/RELEASE/Polyphone"
echo .



