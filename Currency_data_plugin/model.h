#include <QAbstractListModel>
#include <QStringList>

#include "CurrencyData.h"

namespace url {
class Loader;
}

class QDomDocument;
class CurrencyDataModel : public QAbstractListModel
{
    Q_OBJECT
public:
    CurrencyDataModel(QObject *parent = 0);

    void append(CurrencyData data);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    Q_INVOKABLE void refresh();

protected:
    QHash<int, QByteArray> roleNames() const;

private Q_SLOTS:
    void onAsyncDownload(const QDomDocument &doc);

private:
    void fillModel();
    void fillFromDom(const QDomDocument &doc);

private:
    QList<CurrencyData> m_currencies;
    url::Loader *m_loader;
};



