#ifndef ENUMPROVIDER_H
#define ENUMPROVIDER_H

#include <QObject>

//Encapsulates enums from data model
class EnumProvider: public QObject {
    Q_OBJECT
public:
    EnumProvider(QObject *parent = 0): QObject(parent) {}
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
