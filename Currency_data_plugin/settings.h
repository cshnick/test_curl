#ifndef SETTINGS_H
#define SETTINGS_H

#include <QSettings>

class Settings : public QSettings
{
    Q_OBJECT

public:
    Q_PROPERTY(bool Android READ Android)
    Q_PROPERTY(bool Unix READ Unix)
    Q_PROPERTY(bool QmlPlasmoid READ QmlPlasmoid)

    explicit Settings(QObject *parent = 0);
    ~Settings();

    enum SEnum {
        ENUM1 = 50,
        ENUM2
    };

    bool Android() const;
    bool Unix() const;
    bool QmlPlasmoid() const;

    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;
};

Q_DECLARE_METATYPE(Settings*)

#endif // SETTINGS_H
