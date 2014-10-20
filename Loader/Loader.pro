#TEMPLATE = lib
#TARGET = $$qtLibraryTarget(urlLoader)
TEMPLATE = app
TARGET = urlLoader

CONFIG += c++11
QT += xml
LIBS += -lcurl

SOURCES += \
    src/loader.cpp \
    src/main.cpp

HEADERS += \
    src/loader.h

QMAKE_CXXFLAGS += -std=c++11
