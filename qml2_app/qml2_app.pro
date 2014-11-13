TEMPLATE = app

QT += qml quick

SOURCES += main.cpp

RESOURCES += qml.qrc
DESTDIR = ../bin

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

android {
    ANDROID_EXTRA_LIBS += $$OUT_PWD/../bin/CurrcData/libcurrcdataplugin.so
}
