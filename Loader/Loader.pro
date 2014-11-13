TEMPLATE = lib
TARGET = $$qtLibraryTarget(urlLoader)
#TEMPLATE = app
#TARGET = urlLoader
DESTDIR = ../bin/CurrcData

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

HEADERS += \
    src/loader.h \
    global.h \

QMAKE_CXXFLAGS += -std=c++11
