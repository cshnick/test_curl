TEMPLATE = lib
TARGET = $$qtLibraryTarget(urlLoader)
#TEMPLATE = app
#TARGET = urlLoader
DESTDIR = ../bin/CurrcData

DEFINES += URLLOADER_LIBRARY

CONFIG += c++11
QT += xml
LIBS += -lcurl

SOURCES += \
    src/loader.cpp \
    #src/main.cpp \

HEADERS += \
    src/loader.h \
    global.h \

QMAKE_CXXFLAGS += -std=c++11
