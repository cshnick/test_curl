#ifndef LOADER_H
#define LOADER_H

#include "../global.h"
#include <QString>
#include <QtXml>

namespace url {
class LoaderPrivate;

class URLLOADER_EXPORT Loader : public QObject
{
    Q_OBJECT

public:
    Loader();
    Loader(const QString &p_url);
    ~Loader();
    QString url() const;
    void setUrl(const QString &p_url);
    void refresh();

    QDomDocument getDom();

    Q_SIGNAL void documentDownloaded(const QDomDocument &p_doc);

private:
    friend class LoaderPrivate;
    LoaderPrivate *p;
};

} //namespace url

#endif // LOADER_H
