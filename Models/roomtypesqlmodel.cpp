#include "roomtypesqlmodel.h"


RoomTypeSqlModel::RoomTypeSqlModel(QObject *parent): SqlQueryModel(parent)
{

}

QVariant RoomTypeSqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("Mã");
            case 1:
                return tr("Loại phòng");
            case 2:
                return tr("Số giường đơn");
            case 3:
                return tr("Số giường đôi");
            case 4:
                return tr("Giá");
            case 5:
                return tr("Phụ thu");
            case 6:
                return tr("Số khách");
            case 7:
                return tr("Mô tả");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

bool RoomTypeSqlModel::addRow(const QString &name, const QString &sbed, const QString &dbed, const QString &guest, const QString &description, const QString &price, const QString &surcharge)
{
    QSqlQuery _query;
    _query.prepare("INSERT INTO [dbo].[room_type] (name, single_beds, double_beds, price, surcharge, guests, description, deleted) "
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    _query.addBindValue(name);
    _query.addBindValue(sbed.toInt());
    _query.addBindValue(dbed.toInt());
    _query.addBindValue(price.toLongLong());
    _query.addBindValue(surcharge.toLongLong());
    _query.addBindValue(guest.toInt());
    _query.addBindValue(description);
    _query.addBindValue(0);
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

bool RoomTypeSqlModel::updateRow(int id, const QString &name, const QString &sbed, const QString &dbed, const QString &guest, const QString &description, const QString &price, const QString &surcharge)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[room_type] SET name = ?, single_beds = ?, double_beds = ?, price = ?, surcharge = ?, guests = ?, description = ? WHERE id = ?");
    _query.addBindValue(name);
    _query.addBindValue(sbed.toInt());
    _query.addBindValue(dbed.toInt());
    _query.addBindValue(price.toLongLong());
    _query.addBindValue(surcharge.toLongLong());
    _query.addBindValue(guest.toInt());
    _query.addBindValue(description);
    auto record = this->record(id);
    _query.addBindValue(record.field("id").value().toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

bool RoomTypeSqlModel::deleteRow(int row)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[room_type] SET deleted = ? WHERE id = ?");
    _query.addBindValue(1);
    auto record = this->record(row);
    _query.addBindValue(record.field("id").value().toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

void RoomTypeSqlModel::populate()
{
     setQuery("SELECT [id]"
              ",[name]"
              ",[single_beds]"
              ",[double_beds]"
              ",[price]"
              ",[surcharge]"
              ",[guests]"
              ",[description]"
              "FROM [dbo].[room_type] WHERE deleted <> 1");
}

RoomTypeDto * RoomTypeSqlModel::get(int index)
{
    RoomTypeDto *r = new RoomTypeDto;
    auto record = this->record(index);
    r->setName(record.field("name").value().toString());
    r->setSingleBeds(record.field("single_beds").value().toInt());
    r->setDoubleBeds(record.field("double_beds").value().toInt());
    r->setGuests(record.field("guests").value().toInt());
    r->setPrice(record.field("price").value().toLongLong());
    r->setSurcharge(record.field("surcharge").value().toLongLong());
    r->setDescription(record.field("description").value().toString());
    return r;
}
