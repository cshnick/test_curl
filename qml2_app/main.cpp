
#ifdef PLASMA_WIDGET
#include <QApplication>
#include "qtquick1applicationviewer.h"
#define APPLICATION QApplication
#else
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#define APPLICATION QGuiApplication
#endif //PLASMA_WIDGET

#include <QDebug>
#include <QFile>

int main(int argc, char *argv[])
{
    APPLICATION app(argc, argv);

#ifndef PLASMA_WIDGET
    QQmlApplicationEngine engine;
#ifdef Q_OS_ANDROID
    engine.addImportPath("assets:/plugins");
#endif //Q_OS_ANDROID
    engine.load(QUrl(QStringLiteral("qrc:/q2Loader.qml")));
    //    engine.load(QUrl(QStringLiteral("qrc:/JustTest.qml")));
#else //PLASMA_WIDGET
    QtQuick1ApplicationViewer viewer;
    viewer.addImportPath(QLatin1String("modules"));
    viewer.setOrientation(QtQuick1ApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qrc:/q1Loader.qml"));
    viewer.showExpanded();
#endif

    return app.exec();
}
