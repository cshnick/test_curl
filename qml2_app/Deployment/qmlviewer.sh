#/bin/bash

if [[ -z $QT_DIR ]] ; then
export QT_BIN=/home/ilia/Development/Qt/Binary/online/5.3/gcc_64/bin
fi
export QML_IMPORT_PATH=`pwd`:$QMLIMPORT_PATH
$QT_BIN/qmlviewer q1Loader.qml 
