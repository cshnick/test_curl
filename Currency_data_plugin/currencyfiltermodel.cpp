#include "currencyfiltermodel.h"

#include "model.h"
#include <QDebug>
#include "CurrencyData.h"
#include "EnumProvider.h"

CurrencyFilterModel::CurrencyFilterModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
    setSourceModel(new CurrencyDataModel);
    setFilterCaseSensitivity(Qt::CaseInsensitive);
}

bool CurrencyFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    const QModelIndex ind = sourceModel()->index(source_row, 0, source_parent);

    QString name_data = ind.data(EnumProvider::NameRole).toString();
    QString code_data = ind.data(EnumProvider::CodeRole).toString();

    bool accept = name_data.contains(filterRegExp())
            || code_data.contains(filterRegExp());

    return accept;
}


void CurrencyFilterModel::stringChanged(const QString &p_str)
{
    setFilterFixedString(p_str);
}

QVariant CurrencyFilterModel::get(int p_index, int role)
{
    return sourceModel()->data(mapToSource(index(p_index, 0)), role);
}
QString CurrencyFilterModel::get_name(int p_index)
{
    return sourceModel()->data(mapToSource(index(p_index, 0)), EnumProvider::NameRole).toString();
}

void CurrencyFilterModel::refresh()
{
    static int i = 0;
    qDebug() << "<=====>CurrencyFilterModel::refresh; call no" << ++i;
    model_impl()->refresh();
}
