#include "servicetypesqlmodel.h"
#include <QSqlQuery>
#include <QSqlRecord>

ServiceTypeSqlModel::ServiceTypeSqlModel(QObject *parent): SqlQueryModel(parent)
{

}

QVariant ServiceTypeSqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("Mã");
            case 1:
                return tr("Loại dịch vụ");
            case 2:
                return tr("Mô tả");
            case 3:
                return tr("Giá");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

bool ServiceTypeSqlModel::add(const QString &name, const QString &description, qint64 base_price)
{
    QSqlQuery _query;
    _query.prepare("INSERT INTO [dbo].[service_type]"
                   "([name]"
                   ",[description]"
                   ",[base_price]"
                   ",[deleted])"
             "VALUES (?,?,?,?)");
    _query.addBindValue(name);
    _query.addBindValue(description);
    _query.addBindValue(base_price);
    _query.addBindValue(0);
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

bool ServiceTypeSqlModel::update(int id, const QString &name, const QString &description, qint64 base_price)
{
    QSqlQuery _query;
    QSqlRecord _record = this->record(id);
    _query.prepare("UPDATE [dbo].[service_type]"
                   "SET [name] = ?"
                   ",[description] = ?"
                   ",[base_price] = ? WHERE id = ?");
    _query.addBindValue(name);
    _query.addBindValue(description);
    _query.addBindValue(base_price);
    _query.addBindValue(_record.field("id").value().toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

bool ServiceTypeSqlModel::remove(int id)
{

}

ServiceTypeDto *ServiceTypeSqlModel::get(int index)
{
    ServiceTypeDto *r = new ServiceTypeDto();
    QSqlRecord _record = this->record(index);
    r->setBasePrice(_record.field("base_price").value().toLongLong());
    r->setDescription(_record.field("description").value().toString());
    r->setName(_record.field("name").value().toString());
    return r;
}

void ServiceTypeSqlModel::populate()
{
    setQuery("SELECT [id]"
             ",[name]"
             ",[description]"
             ",[base_price]"
             "FROM [dbo].[service_type]");
}
