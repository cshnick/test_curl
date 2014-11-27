#include "loader.h"
#include "loader_private_qt.h"

#include <QtNetwork>

namespace url {

LoaderPrivate::LoaderPrivate(Loader *p_q, QObject *parent)
    : QObject(parent)
    ,q(p_q)
{
    m_manager = new QNetworkAccessManager(this);
    connect(m_manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));
}

bool LoaderPrivate::getBuffer()
{
    return true;
}

void LoaderPrivate::refresh()
{
    if (!m_buffer.isEmpty()) {
        m_buffer.clear();
    }
    if (m_url.isEmpty()) {
        return;
    }
    m_manager->get(QNetworkRequest(QUrl(m_url)));
}

QDomDocument LoaderPrivate::getDom()
{
    if (m_buffer.isEmpty()) {
        if (!m_url.isEmpty()) {
            m_manager->get(QNetworkRequest(QUrl(m_url)));
        }
        return QDomDocument();
    }
    QDomDocument res;
    if (!res.setContent(m_buffer)) {
        fprintf(stderr, "Failed to parse buffer. Invalid content\n");
        return QDomDocument();
    }

    return res;
}

void LoaderPrivate::resetBuffer()
{
    m_buffer.clear();
}

void LoaderPrivate::replyFinished(QNetworkReply *reply)
{
   m_buffer = reply->readAll();
    if (m_buffer.isEmpty()) {
        return;
    }
    QDomDocument doc = getDom();
    if (!doc.isNull()) {
        emit q->documentDownloaded(doc);
    }
}

Loader::Loader() :
	p(new LoaderPrivate(this))
{
}
Loader::Loader(const QString &p_url) :
    Loader()
{
    setUrl(p_url);
}
Loader::~Loader()
{
	delete p;
}
QString Loader::url() const
{
	return p->m_url;
}
void Loader::setUrl(const QString &p_url)
{
    p->resetBuffer();
    QString t_url = p_url;
    if (!p_url.startsWith("http://")) {
        t_url.prepend("http://");
    }
    p->m_url = t_url;
}
void Loader::refresh()
{
    p->refresh();
}
QDomDocument Loader::getDom()
{
    return p->getDom();
}

} //namespace url
