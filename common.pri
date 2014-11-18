URI=CurrcData

DEFINES += PLASMA_WIDGET
android {
    DEST_PATH=/assets/plugins/$$URI
} else : contains(DEFINES, PLASMA_WIDGET) {
    DEST_IMPORTS=/home/ilia/localbin/imports
    SERVICES_INSTALL_DIR=/home/ilia/.kde4/share/kde4/services
    DATA_INSTALL_DIR=/home/ilia/.kde4/share/apps/plasma/plasmoids
    PLASMOID_NAME=plasma-currency
    DEST_PATH=$$DATA_INSTALL_DIR/$$PLASMOID_NAME/contents/ui
}
