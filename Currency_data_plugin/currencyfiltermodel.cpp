#include "currencyfiltermodel.h"

#include "model.h"
#include <QDebug>
#include "CurrencyData.h"

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
    setFilterFixedString(p_str);
}

CurrencyData *CurrencyFilterModel::get(int p_index)
{
    return sourceModel()->data(mapToSource(index(p_index, 0)), CurrencyDataModel::DataRole).value<CurrencyData*>();
}

void CurrencyFilterModel::refresh()
{
    qDebug() << "CurrencyFilterModel::refresh";
    model_impl()->refresh();
}
