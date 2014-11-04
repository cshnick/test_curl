#ifndef SETTINGS_H
#define SETTINGS_H

#include <QSettings>

class Settings : public QSettings
{
    Q_OBJECT

public:
    explicit Settings(QObject *parent = 0);
    ~Settings();

    enum SEnum {
        ENUM1 = 50,
        ENUM2
    };

    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;
};

Q_DECLARE_METATYPE(Settings*)

#endif // SETTINGS_H
