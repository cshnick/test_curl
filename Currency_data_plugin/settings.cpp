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

void Settings::setValue(const QString &key, const QVariant &value)
{
    QSettings::setValue(key, value);
}
QVariant Settings::value(const QString &key, const QVariant &defaultValue) const
{
    return QSettings::value(key, defaultValue);
}
