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
#ifndef PIESLICE_H
#define PIESLICE_H

#include <QString>
#include <QObject>
#include <QColor>

class CurrencyData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString code READ code WRITE setCode)
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(qreal value READ value WRITE setValue)
    Q_PROPERTY(QColor color_val READ color_val WRITE setColor_val)
    Q_PROPERTY(QString alt_color READ alt_color WRITE setAlt_color)

public:
    CurrencyData(QObject *parent = 0);

    QString code() const;
    void setCode(const QString &code);

    QString name() const;
    void setName(const QString &name);

    qreal value() const;
    void setValue(qreal value);

    QColor color_val();
    void setColor_val(const QColor &p_col);

    QString alt_color();
    void setAlt_color(const QString &p_col);

private:
    QString m_code;
    QString m_name;
    qreal m_value;
    QColor m_color;
    QString m_altcolor;
};

class A : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString test READ test WRITE setTest NOTIFY testChanged)
public:
    explicit A(QObject *parent = 0) : QObject(parent){}

    QString test(){return myTest;}

    void setTest(QString t){
        myTest = t;
        testChanged(myTest);
    }

signals:
    void testChanged(QString t);

private:
    QString myTest;
};


#endif

