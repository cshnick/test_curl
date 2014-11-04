#include <QAbstractListModel>
#include <QStringList>

namespace url {
class Loader;
}

class CurrencyData;
class CurrencyDataModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum CurrencyDataRoles {
        CodeRole = Qt::UserRole + 1,
        ColorNameRole,
        ValueRole,
        NameRole,
        DataRole,
    };
    Q_ENUMS(CurrencyDataRoles)

    CurrencyDataModel(QObject *parent = 0);

    void append(CurrencyData *data);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    Q_INVOKABLE void refresh();

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    void fillModel();
private:
    QList<CurrencyData*> m_currencies;
    url::Loader *m_loader;
};



