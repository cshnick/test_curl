/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the documentation of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include "CurrencyDataSet.h"
#include "CurrencyData.h"


#include "../Loader/src/loader.h"
#include "unistd.h"

//static QColor genColor() {
//    int r = qrand() % 0xFF;
//    int g = qrand() % 0xFF;
//    int b = qrand() % 0XFF;

//    return QColor(r, g, b);
////    return Qt::black;
//}

//static const QString g_fileName = QString(get_current_dir_name()) +"/CurrcData/colors.dat";
//static void genColorsAsStream(const QString fileName, uint elCount) {
//    if (!QFileInfo(fileName).dir().exists()) {
//        qDebug() << "Directory" << fileName << "does not exist";
//        return;
//    }

//    qDebug() << "Starting export" << elCount << "elements to" << fileName << "...";
//    QTime cur = QTime::currentTime();

//    QFile file(fileName);
//    file.open(QIODevice::WriteOnly);

//    QDataStream out(&file);
//    out << elCount;
//    for (uint ind = 0; ind < elCount; ind++) {
//        out << genColor().rgba();
//    }
//    file.close();

//    qDebug() << "Finished color map generation, elapsed time" << cur.msecsTo(QTime::currentTime());
//}

//static struct GColorStack {
//    GColorStack() : m_counter(0) {
//        qDebug() << "GColorStack constructor";

//        if (QFileInfo(g_fileName).exists()) {
//            m_file.setFileName(g_fileName);
//            m_file.open(QIODevice::ReadOnly);
//            m_dataStream.setDevice(&m_file);
//            m_dataStream >> m_count;
//            qDebug() << "GColorStack created, elements number" << m_count;
//        } else {
//            qDebug() << "File" << g_fileName << "does not exist";
//        }
//    }

//    ~GColorStack() {
//        m_file.close();
//    }

//    uint getValue() {
//        if (++m_counter == m_count) {
//            m_counter = 0;
//            m_file.close();
//            m_file.open(QIODevice::ReadOnly);

//            m_dataStream.setDevice(&m_file);
//        }

//        uint tmp;
//        m_dataStream >> tmp;

//        return tmp;
//    }

//    QDataStream m_dataStream;
//    QFile m_file;
//    uint m_count;
//    uint m_counter;
//} g_color_stack;

CurrencyDataSet::CurrencyDataSet(QObject *parent)
    : QObject(parent)
    , m_loader(new url::Loader)
{
//    genColorsAsStream(g_fileName, 1000000);
}

QString CurrencyDataSet::name() const
{
    return m_name;
}

void CurrencyDataSet::setName(const QString &name)
{
    m_name = name;
}

QQmlListProperty<CurrencyData> CurrencyDataSet::dataSet()
{
    return QQmlListProperty<CurrencyData>(this, 0, &CurrencyDataSet::append_data
                                          , &CurrencyDataSet::count_data
                                          , &CurrencyDataSet::data_at
                                          , 0);
}

const QString CurrencyDataSet::dataUrl() const {
    return "rss.timegenie.com/forex.xml";
}

void CurrencyDataSet::refresh()
{
    qDeleteAll(m_dataSet);
    m_dataSet.clear();

    QTime cur = QTime::currentTime();
    qDebug() << "Starting filling data";
    fillVector();
    qDebug() << "retreived data, elapsed time" << cur.msecsTo(QTime::currentTime());
    qDebug() << "new count" << m_dataSet.count();
}

void CurrencyDataSet::fillVector()
{
    m_loader->setUrl(dataUrl());
    QDomDocument doc = m_loader->getDom();
    if (doc.isNull()) {
        qDebug() << "No data within DOM";
        return;
    }
    for (QDomElement nx = doc.documentElement().firstChildElement(); !nx.isNull(); nx = nx.nextSiblingElement()) {
        if (nx.tagName() != "data") {
            continue;
        }
        CurrencyData *cel = new CurrencyData;
        for (QDomElement sx = nx.firstChildElement(); !sx.isNull(); sx = sx.nextSiblingElement()) {
            if (sx.tagName() == "code") {
                cel->setCode(sx.text());
            } else if (sx.tagName() == "description") {
                cel->setName(sx.text());
            } else if (sx.tagName() == "rate") {
                cel->setValue(sx.text().toDouble());
            }
        }
//        uint nextValue = g_color_stack.getValue();
//        cel->setAlt_color(QColor::fromRgba(nextValue).name());
        m_dataSet << cel;
    }
}

void CurrencyDataSet::append_data(QQmlListProperty<CurrencyData> *list, CurrencyData *p_data)
{
    CurrencyDataSet *dset = qobject_cast<CurrencyDataSet*>(list->object);
    if (dset) {
        p_data->setParent(dset);
        dset->m_dataSet.append(p_data);
    }
}

int CurrencyDataSet::count_data(QQmlListProperty<CurrencyData> *list)
{
//    qDebug() << "retreiving count data";
    int res = 0;
    CurrencyDataSet *dset = qobject_cast<CurrencyDataSet*>(list->object);
    if (dset) {
        res = dset->m_dataSet.count();
    }

    return res;
}

CurrencyData *CurrencyDataSet::data_at(QQmlListProperty<CurrencyData> *list, int index)
{
//    qDebug() << "Checking qml index" << index;
    CurrencyData *res = nullptr;
    CurrencyDataSet *dset = qobject_cast<CurrencyDataSet*>(list->object);
    if (dset) {
        res = dset->m_dataSet.at(index);
    }
    return res;
}



