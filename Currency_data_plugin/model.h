#include <QAbstractListModel>
#include <QStringList>
#include <QFile>

#include "CurrencyData.h"

namespace url {
class Loader;
}

struct GColorStack {
    GColorStack();

    ~GColorStack() ;
    uint getValue();

    QDataStream m_dataStream;
    QFile m_file;
    uint m_count;
    uint m_counter;
};

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
    GColorStack m_colorstack;
};



