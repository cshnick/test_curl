include(../common.pri)

TEMPLATE = lib
CONFIG += plugin
CONFIG += c++11
QT +=  xml
contains(DEFINES, PLASMA_WIDGET) {
    QT += declarative
} else {
    QT += qml quick
}

DESTDIR = ../bin/$$URI
TARGET = $$qtLibraryTarget(currcdataplugin)

HEADERS += \
    CurrencyData.h \
    currcplugin.h \
    model.h \
    currencyfiltermodel.h \
    settings.h \
    EnumProvider.h

SOURCES += \
    CurrencyData.cpp \
    currcplugin.cpp \
    model.cpp \
    currencyfiltermodel.cpp \
    settings.cpp

LIBS += -L$${OUT_PWD}/../bin/CurrcData -lurlLoader

#OTHER_FILES += qmldir \
#    ../Additional/colors.dat

 #do the rpath by hand since it's not possible to use ORIGIN in QMAKE_RPATHDIR
# this expands to $ORIGIN (after qmake and make), it does NOT read a qmake var
QMAKE_RPATHDIR += \$\$ORIGIN
QMAKE_RPATHDIR += .
QMAKE_RPATHDIR += \$\$ORIGIN/../lib
IDE_PLUGIN_RPATH = $$join(QMAKE_RPATHDIR, ":")
QMAKE_LFLAGS += -Wl,-z,origin \'-Wl,-rpath,$${IDE_PLUGIN_RPATH}\'
QMAKE_RPATHDIR =

android {
#    message("PWD is $$PWD")
#    message("OUT_PWD is $$OUT_PWD")
#    message("TARGET is $$TARGET")
#    message("DESTDIR is $$DESTDIR")
#    message("DESTDIR_TARGET is $$DESTDIR_TARGET")
#    message("qtLibraryTarget(currcdataplugin) is $$qtLibraryTarget(currcdataplugin)")
    DEST_PATH=/assets/plugins/$$URI
    qmldir.files=$$PWD/qmldir
    qmldir.path=$$DEST_PATH
    target.path=$$DEST_PATH
    INSTALLS += qmldir target
} else: contains(DEFINES, PLASMA_WIDGET) {
    target.path=$$DEST_PATH/$$URI
    qmldir.files=$$PWD/qmldir
    qmldir.path=$$DEST_PATH/$$URI
    INSTALLS += qmldir target
}


# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += $$QMAKE_COPY $$replace($$list($$quote($$PWD/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)

RESOURCES += \
    res.qrc
