#include <iostream>
#include "global.h"
#include "curl/curl.h"
#include <tidy/tidy.h>
#include <tidy/buffio.h>

#include <QtCore>
#include <QString>
#include "loader.h"

using namespace std;

QString getPageContent(const QString &sourcePage) {
    CURL *curl;
    CURLcode res;

    curl = curl_easy_init();
    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, qPrintable(sourcePage));
        /* example.com is redirected, so we tell libcurl to follow redirection */
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);

        /* Perform the request, res will get the return code */
        res = curl_easy_perform(curl);
        /* Check for errors */
        if(res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n",
                    curl_easy_strerror(res));

        /* always cleanup */
        curl_easy_cleanup(curl);
    }
    return QString();
}

int main()
{
#if __cplusplus > 201100L
    cout << "Hello C++11 World!" << endl;
#endif
//    getPageContent("www.w3schools.com/xml/note.xml");
    url::Loader ldr("rss.timegenie.com/forex.xml");

    return 0;
}
