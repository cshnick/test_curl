#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
#ifdef Q_OS_ANDROID
//    engine.load(QUrl(QStringLiteral("qrc:/main_abstrmdl.qml")));
    engine.addImportPath("assets:/plugins");
#endif
    engine.load(QUrl(QStringLiteral("qrc:/CMainList.qml")));

    return app.exec();
}
