#include "loader.h"

//#include "curl/curl.h"

namespace url {

static int writer(char *data, size_t size, size_t nmemb,
		QString *writerData)
{
	if (writerData == nullptr)
		return 0;

//    qDebug() << "data" << data;
//    qDebug() << "len" << strlen(data);

	writerData->append(data);

    return size*nmemb;
}

int loader_main(int argc, const char**argv) {

	return 1;
}

class LoaderPrivate {
	friend class Loader;
public:
	LoaderPrivate(Loader *p_q): q(p_q) {}

	bool getBuffer()
	{
		if (m_url.isEmpty()) {
			return false;
		}

        if (!m_buffer.isNull()) {
            m_buffer.clear();
        }

		CURL *conn = NULL;
		CURLcode code;
		std::string title;

		curl_global_init(CURL_GLOBAL_DEFAULT);
		conn = curl_easy_init();

		if (conn == NULL) {
			fprintf(stderr, "Failed to create CURL connection\n");
			m_buffer.clear();
			return false;
		}
		code = curl_easy_setopt(conn, CURLOPT_ERRORBUFFER, m_errorBuffer);
		if (code != CURLE_OK) 	{
			fprintf(stderr, "Failed to set error buffer [%d]\n", code);
			m_buffer.clear();
			return false;
		}
		code = curl_easy_setopt(conn, CURLOPT_URL, qPrintable(m_url));
		if (code != CURLE_OK) {
			fprintf(stderr, "Failed to set URL [%s]\n", m_errorBuffer);
			return false;
		}
		code = curl_easy_setopt(conn, CURLOPT_FOLLOWLOCATION, 1);
		if (code != CURLE_OK) {
			fprintf(stderr, "Failed to set redirect option [%s]\n", m_errorBuffer);
			m_buffer.clear();
			return false;
		}
		code = curl_easy_setopt(conn, CURLOPT_WRITEFUNCTION, writer);
		if (code != CURLE_OK) {
			fprintf(stderr, "Failed to set writer [%s]\n", m_errorBuffer);
			m_buffer.clear();
			return false;
		}
        code = curl_easy_setopt(conn, CURLOPT_WRITEDATA, &m_buffer);
		if (code != CURLE_OK) {
			fprintf(stderr, "Failed to set write data [%s]\n", m_errorBuffer);
			m_buffer.clear();
			return false;
		}

		code = curl_easy_perform(conn);
		curl_easy_cleanup(conn);

		return true;
	}

private:
	Loader *q;

	QString m_url;
	QString m_buffer;
	mutable int m_error = 0;
	mutable char *m_errorBuffer[CURL_ERROR_SIZE];
};

Loader::Loader() :
	p(new LoaderPrivate(this))
{
}
Loader::Loader(const QString &p_url) :
    Loader()
{
    p->m_url = p_url;
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
	p->m_url = p_url;
}
void Loader::refresh()
{
	p->getBuffer();
}
QDomDocument Loader::getDom()
{
	QDomDocument res;
//    refresh();
    if (p->m_buffer.isNull()) {
        p->getBuffer();
    }
    if (!res.setContent(p->m_buffer)) {
		fprintf(stderr, "Failed to parse buffer. Invalid content\n");
		return QDomDocument();
	}

	return res;
}
} //namespace url
