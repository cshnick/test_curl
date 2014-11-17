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

GColorStack::GColorStack() : m_counter(0) {
    qDebug() << "GColorStack constructor";

    m_file.setFileName(":/Colors/colors.dat");
    if (m_file.open(QIODevice::ReadOnly)) {
        m_dataStream.setDevice(&m_file);
        m_dataStream >> m_count;
        qDebug() << "GColorStack created, elements number" << m_count;
    } else {
        qDebug() << "File" << m_file.fileName() << "does not exist";
    }
}

GColorStack::~GColorStack() {
    m_file.close();
}

uint GColorStack::getValue() {
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


ForexParser::ForexParser(CurrencyDataModel *p) : m_context(p) {}
DomParser *ForexParser::create(CurrencyDataModel *p_context)
{
    return new ForexParser(p_context);
}
QString ForexParser::url() const
{
    return "rss.timegenie.com/forex.xml";
}
void ForexParser::parse(const QDomDocument &doc)
{
    if (!m_context || doc.isNull()) {
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
        uint nextValue = m_context->m_colorstack.getValue();
        cel.setAlt_color(QColor::fromRgba(nextValue).name());
        m_context->append(cel);
    }
}

NbRbParser::NbRbParser(CurrencyDataModel *p) : m_context(p) {}
DomParser *NbRbParser::create(CurrencyDataModel *p_context)
{
    return new NbRbParser(p_context);
}
QString NbRbParser::url() const
{
    return "http://www.nbrb.by/Services/XmlExRates.aspx";
}
void NbRbParser::parse(const QDomDocument &doc)
{
    if (!m_context || doc.isNull()) {
        return;
    }
    //RB is hardcoded
    CurrencyData byr;
    byr.setCode("BYR");
    byr.setName("Белорусский рубль");
    byr.setValue(1.0);
    uint nextValue = m_context->m_colorstack.getValue();
    byr.setAlt_color(QColor::fromRgba(nextValue).name());
    m_context->append(byr);

    for (QDomElement nx = doc.documentElement().firstChildElement(); !nx.isNull(); nx = nx.nextSiblingElement()) {
        qDebug() << "nbrb tag name" << nx.tagName();
        if (nx.tagName() != "Currency") {
            continue;
        }
        CurrencyData cel;
        for (QDomElement sx = nx.firstChildElement(); !sx.isNull(); sx = sx.nextSiblingElement()) {
            if (sx.tagName() == "CharCode") {
                cel.setCode(sx.text());
            } else if (sx.tagName() == "Name") {
                cel.setName(sx.text());
            } else if (sx.tagName() == "Rate") {
                cel.setValue(sx.text().toDouble());
            }
        }
        uint nextValue = m_context->m_colorstack.getValue();
        cel.setAlt_color(QColor::fromRgba(nextValue).name());
        m_context->append(cel);
    }
}

CurrencyDataModel::CurrencyDataModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_loader(new url::Loader)
{
    qDebug() << "CurrencyDataModel constructor start";
    m_parser = DomParser::create<NbRbParser>(this);
//    m_parser = DomParser::create<ForexParser>(this);
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
    m_loader->setUrl(m_parser->url());
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
    m_parser->parse(doc);
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
