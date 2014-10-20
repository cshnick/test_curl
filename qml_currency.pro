TEMPLATE = subdirs
CONFIG += ordered
SUBDIRS = \
          Loader \
          Currency_data_plugin \
#          qml_app

#system("mkdir -p $$CWD/bin")
message($$OUT_PWD)
