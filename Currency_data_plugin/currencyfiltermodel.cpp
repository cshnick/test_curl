#include "currencyfiltermodel.h"

#include "model.h"
#include <QDebug>
#include "CurrencyData.h"
#include "EnumProvider.h"

const QString forex_string = "forex";
const QString nbrb_string = "nbrb";

QString currencyE2S(int p_ldr)
{
    QString result;
    switch(p_ldr) {
    case url::E_FOREX_LOADER:
        result = forex_string;
        break;
    case url::E_NBRB_LOADER:
        result = nbrb_string;
        break;
    }
    return result;
}

url::Currency_Loader currencyS2E(const QString &p_strtype)
{
    url::Currency_Loader result;
    if (p_strtype == forex_string) {
        result =  url::E_FOREX_LOADER;
    } else if (p_strtype == nbrb_string) {
        result = url::E_NBRB_LOADER;
    }

    return result;
}

CurrencyFilterModel::CurrencyFilterModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
    setSourceModel(new CurrencyDataModel);
    sort(0);
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

bool CurrencyFilterModel::lessThan(const QModelIndex &left, const QModelIndex &right) const
{
//    qDebug() << "less than call";

    QString name_data_left = left.data(EnumProvider::NameRole).toString();
    QString code_data_left = left.data(EnumProvider::CodeRole).toString();

    QString name_data_right = right.data(EnumProvider::NameRole).toString();
    QString code_data_fight = right.data(EnumProvider::CodeRole).toString();

    return name_data_left < name_data_right;
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

int CurrencyFilterModel::indexFromCode(const QString &code)
{
    int res = mapFromSource(sourceModel()->index(model_impl()->indexFromCode(code), 0)).row();
    return res;
}

QString CurrencyFilterModel::parser()
{
    return model_impl()->current_parser()->loaderTypeString();
}

void CurrencyFilterModel::setParser(const QString &p_parser)
{
    Q_UNUSED(p_parser)
    qDebug() << "CurrencyFilterModel::setLoader(const QString &p_loader) is not implemented yet";
}
