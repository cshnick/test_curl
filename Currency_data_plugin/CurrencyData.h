#ifndef PIESLICE_H
#define PIESLICE_H

#include <QString>
#include <QObject>
#include <QColor>

class CurrencyData
{

public:
    CurrencyData();

    QString code() const;
    void setCode(const QString &code);

    QString name() const;
    void setName(const QString &name);

    qreal value() const;
    void setValue(qreal value);

    QColor color_val();
    void setColor_val(const QColor &p_col);

    QString alt_color() const;
    void setAlt_color(const QString &p_col);

private:
    QString m_code;
    QString m_name;
    qreal m_value;
    QString m_altcolor;
};

#endif

