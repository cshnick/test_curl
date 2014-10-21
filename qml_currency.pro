TEMPLATE = subdirs
CONFIG += ordered
SUBDIRS = \
          Loader \
          Currency_data_plugin \
          qml2_app

#system("mkdir -p $$CWD/bin")
message($$OUT_PWD)

CONFIG += c++11
