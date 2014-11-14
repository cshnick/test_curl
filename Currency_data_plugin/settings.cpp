#include "settings.h"
#include <QtCore>

Settings::Settings(QObject *parent)
    : QSettings(QSettings::IniFormat,
                QSettings::UserScope,
                "Cshnick",
                QCoreApplication::instance()->applicationName(),
                parent)
{
}
Settings::~Settings()
{
    qDebug() << "=== Settings destructor ===";
}

bool Settings::Android() const {
#ifdef Q_OS_ANDROID
    return true;
#else
    return false;
#endif
}
bool Settings::Unix() const {
#ifdef Q_OS_UNIX
    return true;
#else
    return false;
#endif
}

void Settings::setValue(const QString &key, const QVariant &value)
{
    QSettings::setValue(key, value);
}
QVariant Settings::value(const QString &key, const QVariant &defaultValue) const
{
    return QSettings::value(key, defaultValue);
}
