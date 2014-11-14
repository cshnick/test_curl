#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QFile>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
#ifdef Q_OS_ANDROID
    QFile f;
    f.setFileName("assets:/colorstack/colors.dat");
    if (f.open(QIODevice::ReadOnly)) {
        qDebug() << "Opened asset file";
    }
    engine.addImportPath("assets:/plugins");
#endif
    engine.load(QUrl(QStringLiteral("qrc:/CMainList.qml")));
//    engine.load(QUrl(QStringLiteral("qrc:/JustTest.qml")));

    return app.exec();
}
