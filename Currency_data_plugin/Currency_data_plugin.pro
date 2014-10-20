TEMPLATE = lib
CONFIG += plugin
QT += qml quick xml

DESTDIR = ../CurrcData
TARGET = $$qtLibraryTarget(currcdataplugin)

HEADERS += \
    CurrencyData.h \
    CurrencyDataSet.h \
    currcplugin.h

SOURCES += \
    CurrencyData.cpp \
    CurrencyDataSet.cpp \
    currcplugin.cpp

#//DESTPATH=$$[QT_INSTALL_EXAMPLES]/qml/tutorials/extending/chapter6-plugins/Charts

#target.path=$$DESTPATH
#qmldir.files=$$PWD/qmldir
#qmldir.path=$$DESTPATH
#INSTALLS += target qmldir

OTHER_FILES += qmldir

# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += $$QMAKE_COPY $$replace($$list($$quote($$PWD/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)
