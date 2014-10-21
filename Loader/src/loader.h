#ifndef LOADER_H
#define LOADER_H

#include "../global.h"
#include <QString>
#include <QtXml>

#include "curl/curl.h"

namespace url {
class LoaderPrivate;

class URLLOADER_EXPORT Loader
{
	friend class LoaderPrivate;
public:
    Loader();
    Loader(const QString &p_url);
    ~Loader();
    QString url() const;
    void setUrl(const QString &p_url);
    void refresh();

    QDomDocument getDom();

private:
    LoaderPrivate *p;
};

} //namespace url

#endif // LOADER_H
