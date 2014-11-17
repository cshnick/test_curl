URI=CurrcData

DEFINES += PLASMA_WIDGET
android {
    DEST_PATH=/assets/plugins/$$URI
} else : contains(DEFINES, PLASMA_WIDGET) {
    DEST_PATH=$$OUT_PWD/../plasma_currency/contents/ui
}
