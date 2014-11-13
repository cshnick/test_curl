TEMPLATE = lib
TARGET = $$qtLibraryTarget(urlLoader)
#TEMPLATE = app
#TARGET = urlLoader
URI=CurrcData
DESTDIR = ../bin/$$URI

DEFINES += URLLOADER_LIBRARY

CONFIG += c++11
QT += xml

#CONFIG += lib_curl

lib_curl {
    SOURCES += src/loader_curl.cpp
    LIBS += -lcurl
} else {
    HEADERS += src/loader_private_qt.h
    SOURCES += src/loader_qt.cpp
    QT += network
}

android {
    DEST_PATH=/assets/plugins/$$URI
    target.path=$$DEST_PATH
    INSTALLS += target
}

HEADERS += \
    src/loader.h \
    global.h \

QMAKE_CXXFLAGS += -std=c++11
