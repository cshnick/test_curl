#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main_abstrmdl.qml")));
    engine.load(QUrl(QStringLiteral("qrc:/CMainList.qml")));

    return app.exec();
}
