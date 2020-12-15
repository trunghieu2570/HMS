#ifndef INVENTORYSQLMODEL_H
#define INVENTORYSQLMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlField>
#include <Dto/inventorydto.h>


class InventorySqlModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit InventorySqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE bool addRow(const QString &name);
    Q_INVOKABLE bool updateRow(int id, const QString &name = nullptr);
    Q_INVOKABLE bool deleteRow(int id);
    Q_INVOKABLE InventoryDto *get(int index);
    Q_INVOKABLE void populate(const QString &keyword = nullptr);
};

#endif // INVENTORYSQLMODEL_H
