include(../common.pri)

TEMPLATE = app
QT += qml quick xml
SOURCES += main.cpp

contains(DEFINES, PLASMA_WIDGET) {
    include(qtquick1applicationviewer/qtquick1applicationviewer.pri)
}

RESOURCES += qml.qrc
DESTDIR = ../bin

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

android {
    ANDROID_EXTRA_LIBS += $$OUT_PWD/../bin/CurrcData/libcurrcdataplugin.so \
                          $$OUT_PWD/../bin/CurrcData/liburlLoader.so
} else: contains(DEFINES, PLASMA_WIDGET) {
    QML_FILEPATH=$$PWD/qml
    DEPLOYMENT_FILEPATH=$$PWD/Deployment
    qml.files = $$QML_FILEPATH/CInputEdit.qml \
                $$QML_FILEPATH/CListView.qml \
                $$QML_FILEPATH/CMainList.qml \
                $$QML_FILEPATH/q1Loader.qml \
                $$QML_FILEPATH/MainListHelper.js \
                $$DEPLOYMENT_FILEPATH/qmlviewer.sh \

    qml.path = $$DEST_PATH
    metafile.files = $$DEPLOYMENT_FILEPATH/metadata.desktop
    metafile.path = $$DEST_PATH/../../

    INSTALLS += qml metafile
}
