include(../common.pri)
TEMPLATE = lib
TARGET = $$qtLibraryTarget(urlLoader)
#TEMPLATE = app
#TARGET = urlLoader
DESTDIR = ../bin/$$URI

DEFINES += URLLOADER_LIBRARY

CONFIG += c++11
QT += xml

#contains(DEFINES, PLASMA_WIDGET) {
#    CONFIG += lib_curl
#}

lib_curl {
    SOURCES += src/loader_curl.cpp
    LIBS += -lcurl
} else {
    HEADERS += src/loader_private_qt.h
    SOURCES += src/loader_qt.cpp
    QT += network
}

android {
    target.path=$$DEST_PATH
    INSTALLS += target
} else: contains(DEFINES, PLASMA_WIDGET) {
    target.path=$$DEST_IMPORTS/$$URI
    INSTALLS += target
}

HEADERS += \
    src/loader.h \
    global.h \

QMAKE_CXXFLAGS += -std=c++11
