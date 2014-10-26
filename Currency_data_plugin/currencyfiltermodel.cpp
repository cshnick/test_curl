#include "currencyfiltermodel.h"

#include "model.h"
#include <QDebug>

CurrencyFilterModel::CurrencyFilterModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
    setSourceModel(new CurrencyDataModel);
    setFilterCaseSensitivity(Qt::CaseInsensitive);
}

bool CurrencyFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    const QModelIndex ind = sourceModel()->index(source_row, 0, source_parent);

    QString name_data = ind.data(CurrencyDataModel::NameRole).toString();
    QString code_data = ind.data(CurrencyDataModel::CodeRole).toString();

    bool accept = name_data.contains(filterRegExp())
            || code_data.contains(filterRegExp());

    return accept;
//    return true;
}

//bool CurrencyFilterModel::lessThan(const QModelIndex &left, const QModelIndex &right) const
//{
//    return true;
//}

void CurrencyFilterModel::stringChanged(const QString &p_str)
{
    qDebug() << "Here is changed string:" << p_str;
//    setFilterRegExp(QRegExp(p_str));
    setFilterFixedString(p_str);
}

void CurrencyFilterModel::refresh()
{
    qDebug() << "CurrencyFilterModel::refresh";
    model_impl()->refresh();
}
