TEMPLATE = lib
CONFIG += plugin
CONFIG += c++11
QT += qml quick xml

DESTDIR = ../bin/CurrcData
TARGET = $$qtLibraryTarget(currcdataplugin)

HEADERS += \
    CurrencyData.h \
    CurrencyDataSet.h \
    currcplugin.h \
    model.h \
    currencyfiltermodel.h \
    settings.h \
    EnumProvider.h

SOURCES += \
    CurrencyData.cpp \
    CurrencyDataSet.cpp \
    currcplugin.cpp \
    model.cpp \
    currencyfiltermodel.cpp \
    settings.cpp

LIBS += -L$${OUT_PWD}/../bin/CurrcData -lurlLoader
message("looking for a bin"$${OUT_PWD}/../bin)

OTHER_FILES += qmldir

 #do the rpath by hand since it's not possible to use ORIGIN in QMAKE_RPATHDIR
# this expands to $ORIGIN (after qmake and make), it does NOT read a qmake var
QMAKE_RPATHDIR += \$\$ORIGIN
QMAKE_RPATHDIR += .
QMAKE_RPATHDIR += \$\$ORIGIN/../lib
IDE_PLUGIN_RPATH = $$join(QMAKE_RPATHDIR, ":")
QMAKE_LFLAGS += -Wl,-z,origin \'-Wl,-rpath,$${IDE_PLUGIN_RPATH}\'
QMAKE_RPATHDIR =


# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += $$QMAKE_COPY $$replace($$list($$quote($$PWD/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)
