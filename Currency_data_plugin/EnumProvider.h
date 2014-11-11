#ifndef ENUMPROVIDER_H
#define ENUMPROVIDER_H

#include <QObject>
#include <QDebug>

//Encapsulates enums from data model
class EnumProvider: public QObject {
    Q_OBJECT
public:
    EnumProvider(QObject *parent = 0): QObject(parent)
    {
        int counter = 0;
        qDebug() << "Enum provider constructor call no" << ++counter;
    }
    enum CurrencyDataRoles {
        CodeRole = Qt::UserRole + 1,
        ColorNameRole,
        ValueRole,
        NameRole,
        DataRole,
    };
    Q_ENUMS(CurrencyDataRoles)
};


#endif // ENUMPROVIDER_H
