#include <QAbstractListModel>
#include <QStringList>
#include <QFile>

#include "CurrencyData.h"

namespace url {
class Loader;

enum Currency_Loader {
    E_FOREX_LOADER = 0,
    E_NBRB_LOADER
};
}

class QDomDocument;
class CurrencyDataModel;

struct GColorStack {
    GColorStack();

    ~GColorStack() ;
    uint getValue();

    QDataStream m_dataStream;
    QFile m_file;
    uint m_count;
    uint m_counter;
};

class DomParser {
public:
    template<class Dereived>
    static DomParser *create(CurrencyDataModel *p_context) {return Dereived::create(p_context);}
    virtual QString url() const = 0;
    virtual void parse(const QDomDocument &doc) = 0;
    virtual url::Currency_Loader loaderType() const = 0;
    virtual QString loaderTypeString() const = 0;
};

class ForexParser : public DomParser {
public:
    ForexParser(CurrencyDataModel *p);
    static DomParser *create(CurrencyDataModel *p_context);
    QString url() const;
    void parse(const QDomDocument &doc);
    url::Currency_Loader loaderType() const;
    QString loaderTypeString() const;

private:
    CurrencyDataModel *m_context;
};

class NbRbParser : public DomParser {
public:
    NbRbParser(CurrencyDataModel *p);
    static DomParser *create(CurrencyDataModel *p_context);
    virtual QString url() const;
    void parse(const QDomDocument &doc);
    url::Currency_Loader loaderType() const;
    QString loaderTypeString() const;

private:
    CurrencyDataModel *m_context;
};

class CurrencyDataModel : public QAbstractListModel
{
    friend class ForexParser;
    friend class NbRbParser;

    Q_OBJECT
public:
    enum Currency_Loader {
        E_FOREX_LOADER = 0,
        E_NBRB_LOADER
    };

    CurrencyDataModel(QObject *parent = 0);

    void append(CurrencyData data);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    DomParser *parser() const {return m_parser;}
    Q_INVOKABLE void refresh();
    int indexFromCode(const QString &code);

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
    DomParser *m_parser;
};



