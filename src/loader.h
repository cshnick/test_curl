#ifndef LOADER_H
#define LOADER_H

#include <QString>

namespace url {

class Loader
{
public:
    Loader();
    Loader(const QString &p_url);
    QString url() const {return m_url;}
    void setUrl(const QString &p_url) {m_url = p_url;}

private:
    QString m_url;
    mutable int m_error;
};

} //namespace url

#endif // LOADER_H
