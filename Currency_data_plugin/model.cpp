#include "model.h"
#include "../Loader/src/loader.h"
#include "unistd.h"
#include "EnumProvider.h"

static QColor genColor() {
    int r = qrand() % 0xFF;
    int g = qrand() % 0xFF;
    int b = qrand() % 0XFF;

    return QColor(r, g, b);
//    return Qt::black;
}

static const QString g_data_url = "rss.timegenie.com/forex.xml";
static const QString g_fileName = qApp->applicationDirPath() +"/CurrcData/colors.dat";
static void genColorsAsStream(const QString fileName, uint elCount) {
    if (!QFileInfo(fileName).dir().exists()) {
        qDebug() << "Directory" << fileName << "does not exist";
        return;
    }

    qDebug() << "Starting export" << elCount << "elements to" << fileName << "...";
    QTime cur = QTime::currentTime();

    QFile file(fileName);
    file.open(QIODevice::WriteOnly);

    QDataStream out(&file);
    out << elCount;
    for (uint ind = 0; ind < elCount; ind++) {
        out << genColor().rgba();
    }
    file.close();

    qDebug() << "Finished color map generation, elapsed time" << cur.msecsTo(QTime::currentTime());
}

static struct GColorStack {
    GColorStack() : m_counter(0) {
        qDebug() << "GColorStack constructor";

        if (QFileInfo(g_fileName).exists()) {
            m_file.setFileName(g_fileName);
            m_file.open(QIODevice::ReadOnly);
            m_dataStream.setDevice(&m_file);
            m_dataStream >> m_count;
            qDebug() << "GColorStack created, elements number" << m_count;
        } else {
            qDebug() << "File" << g_fileName << "does not exist";
        }
    }

    ~GColorStack() {
        m_file.close();
    }

    uint getValue() {
        if (++m_counter == m_count) {
            m_counter = 0;
            m_file.close();
            m_file.open(QIODevice::ReadOnly);

            m_dataStream.setDevice(&m_file);
        }

        uint tmp;
        m_dataStream >> tmp;

        return tmp;
    }

    QDataStream m_dataStream;
    QFile m_file;
    uint m_count;
    uint m_counter;
} g_color_stack;

CurrencyDataModel::CurrencyDataModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_loader(new url::Loader)
{
    qDebug() << "CurrencyDataModel constructor start";
    connect(m_loader, SIGNAL(documentDownloaded(QDomDocument)), this, SLOT(onAsyncDownload(QDomDocument)));
}

void CurrencyDataModel::append(CurrencyData data)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_currencies << data;
    endInsertRows();
}

int CurrencyDataModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_currencies.count();
}

QVariant CurrencyDataModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_currencies.count())
        return QVariant();

    CurrencyData csdta = m_currencies.at(index.row());
    switch (role) {
    case EnumProvider::NameRole:
        return csdta.name();
        break;
    case EnumProvider::CodeRole:
        return csdta.code();
        break;
    case EnumProvider::ColorNameRole:
        return csdta.alt_color();
        break;
    case EnumProvider::ValueRole:
        return csdta.value();
        break;

    default:
        return QVariant();
    }
}

QHash<int, QByteArray> CurrencyDataModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[EnumProvider::CodeRole] = "code";
    roles[EnumProvider::ColorNameRole] = "colorCode";
    roles[EnumProvider::ValueRole] = "value";
    roles[EnumProvider::NameRole] = "name";
    return roles;
}

void CurrencyDataModel::onAsyncDownload(const QDomDocument &doc)
{
    fillFromDom(doc);
}

void CurrencyDataModel::fillModel()
{
    m_loader->setUrl(g_data_url);
    QDomDocument doc = m_loader->getDom();
    if (doc.isNull()) {
        qDebug() << "No data within DOM";
        return;
    }
    fillFromDom(doc);
}

void CurrencyDataModel::fillFromDom(const QDomDocument &doc)
{
    if (doc.isNull()) {
        return;
    }
    for (QDomElement nx = doc.documentElement().firstChildElement(); !nx.isNull(); nx = nx.nextSiblingElement()) {
        if (nx.tagName() != "data") {
            continue;
        }
        CurrencyData cel;
        for (QDomElement sx = nx.firstChildElement(); !sx.isNull(); sx = sx.nextSiblingElement()) {
            if (sx.tagName() == "code") {
                cel.setCode(sx.text());
            } else if (sx.tagName() == "description") {
                cel.setName(sx.text());
            } else if (sx.tagName() == "rate") {
                cel.setValue(sx.text().toDouble());
            }
        }
        uint nextValue = g_color_stack.getValue();
        cel.setAlt_color(QColor::fromRgba(nextValue).name());
        append(cel);
    }
}

void CurrencyDataModel::refresh()
{
    if (m_currencies.count()) {
        beginRemoveRows(QModelIndex(), 0, m_currencies.count() - 1);
        m_currencies.clear();
        endRemoveRows();
    }
    QTime cur = QTime::currentTime();
    qDebug() << "Starting filling data";
    fillModel();
    qDebug() << "retreived data, elapsed time" << cur.msecsTo(QTime::currentTime());
    qDebug() << "new count" << m_currencies.count();
}
