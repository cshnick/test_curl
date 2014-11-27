#ifndef LOADER_PRIVATE_QT_H
#define LOADER_PRIVATE_QT_H

#include <QObject>
#include <QString>
#include <QByteArray>
#include <QDomDocument>
#include "global.h"

class QNetworkAccessManager;
class QNetworkReply;

namespace url {
class Loader;


class URLLOADER_EXPORT LoaderPrivate : public QObject {
    Q_OBJECT
    friend class Loader;
public:
    Q_DECL_EXPORT LoaderPrivate(url::Loader *p_q, QObject *parent = 0);
    bool getBuffer();
    void refresh();
    QDomDocument getDom();
    void resetBuffer();

private Q_SLOTS:
    void replyFinished(QNetworkReply *reply);


private:
    Loader *q;

    QNetworkAccessManager *m_manager;
    QString m_url;
    QByteArray m_buffer;
    mutable int m_error = 0;
};

}

#endif // LOADER_PRIVATE_QT_H
