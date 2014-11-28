#ifndef CURRENCYFILTERMODEL_H
#define CURRENCYFILTERMODEL_H

#include <QSortFilterProxyModel>

class CurrencyDataModel;
class CurrencyData;

class CurrencyFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    Q_PROPERTY(QString parser READ parser WRITE setParser NOTIFY parserChanged)

    explicit CurrencyFilterModel(QObject *parent = 0);
    Q_INVOKABLE void stringChanged(const QString &p_str);
    Q_INVOKABLE QVariant get(int p_index, int role);
    Q_INVOKABLE QString get_name(int p_index);
    Q_INVOKABLE void refresh();
    Q_INVOKABLE int indexFromCode(const QString &code);
    Q_INVOKABLE QStringList parserNames() const;

    QString parser() const;
    void setParser(const QString &p_parser);
    Q_SIGNAL void parserChanged(const QString &parser);

protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;

private:
    CurrencyDataModel *model_impl() {
        return reinterpret_cast<CurrencyDataModel*> (this->sourceModel());
    }
    CurrencyDataModel *model_impl() const {
        return reinterpret_cast<CurrencyDataModel*> (this->sourceModel());
    }
};

#endif // CURRENCYFILTERMODEL_H
