#include "inventorysqlmodel.h"


InventorySqlModel::InventorySqlModel(QObject *parent): SqlQueryModel(parent)
{

}

QVariant InventorySqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("Mã");
            case 1:
                return tr("Tên");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

bool InventorySqlModel::addRow(const QString &name)
{
    QSqlQuery _query;
    _query.prepare("INSERT INTO [dbo].[inventory] (name, deleted) "
                   "VALUES (?, ?)");
    _query.addBindValue(name);
    _query.addBindValue(0);
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

bool InventorySqlModel::updateRow(int id, const QString &name)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[inventory] SET name = ? WHERE id = ?");
    _query.addBindValue(name);
    auto record = this->record(id);
    _query.addBindValue(record.field("id").value().toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

bool InventorySqlModel::deleteRow(int id)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[inventory] SET deleted = ? WHERE id = ?");
    _query.addBindValue(1);
    auto record = this->record(id);
    _query.addBindValue(record.field("id").value().toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

InventoryDto *InventorySqlModel::get(int index)
{
    InventoryDto *r = new InventoryDto;
    auto record = this->record(index);
    r->setName(record.field("name").value().toString());
    return r;
}

void InventorySqlModel::populate(const QString &keyword)
{
    if(keyword == nullptr || keyword == "")
        setQuery("SELECT [id]"
                 ",[name]"
                 "FROM [dbo].[inventory]"
                 "WHERE [deleted] <> 1");
    else {
        QSqlQuery _q;
        _q.prepare("SELECT [id], [name] FROM [HOTEL_DATABASE].[dbo].[inventory] WHERE LOWER(CONCAT([id],' ',[name])) LIKE LOWER(?) AND [deleted] <> 1");
        _q.addBindValue(QString("%%%1%%").arg(keyword));
        _q.exec();
        setQuery(_q);
    }

}


