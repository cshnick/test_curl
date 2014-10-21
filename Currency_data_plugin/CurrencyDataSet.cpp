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


CurrencyDataSet::CurrencyDataSet(QObject *parent)
    : QObject(parent)
    , m_loader(new url::Loader)
{
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
                                          , &CurrencyDataSet::count_data, 0, 0);
}

const QString CurrencyDataSet::dataUrl() const {
    return "rss.timegenie.com/forex.xml";
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
    int res = 0;
    CurrencyDataSet *dset = qobject_cast<CurrencyDataSet*>(list->object);
    if (dset) {
        res = dset->m_dataSet.count();
    }

    return res;
}

CurrencyData *CurrencyDataSet::data_at(QQmlListProperty<CurrencyData> *list, int index)
{
    CurrencyData *res = nullptr;
    CurrencyDataSet *dset = qobject_cast<CurrencyDataSet*>(list->object);
    if (dset) {
        res = dset->m_dataSet.at(index);
    }
    return res;
}



