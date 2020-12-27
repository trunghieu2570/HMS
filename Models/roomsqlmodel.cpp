#include "roomsqlmodel.h"
#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>
#include <QSqlResult>

RoomSqlModel::RoomSqlModel(QObject *parent)
{

}

QVariant RoomSqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("ID");
            case 1:
                return tr("Room");
            case 2:
                return tr("TypeId");
            case 3:
                return tr("Type");
            case 4:
                return tr("Need Clean");
            case 5:
                return tr("Lock");
            case 6:
                return tr("Description");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

void RoomSqlModel::populate()
{
    setQuery("SELECT [room].[id]"
             ",[room].[name]"
             ",[room].[room_type_id]"
             ",[room_type].[name] as [room_type]"
             ",[room].[need_clean]"
             ",[room].[locked]"
             ",[room].[description]"
             ",[room].[deleted]"
             "FROM [room]"
             "LEFT JOIN [room_type] ON [room].[room_type_id] = [room_type].[id]");
}

bool RoomSqlModel::addRoom(const QString &name, int roomTypeId, bool needClean, bool locked, const QString &description, const QList<int> inventoryItems)
{
    QSqlQuery _query;
    _query.prepare("INSERT INTO [dbo].[room]"
                   "([name]"
                   ",[room_type_id]"
                   ",[need_clean]"
                   ",[locked]"
                   ",[description]"
                   ",[deleted])"
                   "VALUES"
                   "(? ,? ,? ,? ,? ,?)");
    _query.addBindValue(name);
    _query.addBindValue(roomTypeId);
    _query.addBindValue(needClean);
    _query.addBindValue(locked);
    _query.addBindValue(description);
    _query.addBindValue(0);
    if (!_query.exec()) {
        qDebug() << QSqlDatabase::database().lastError().text();
        return false;
    }
    int _newId = _query.lastInsertId().toInt();
    for (int i: inventoryItems) {
        _query.prepare("INSERT INTO [dbo].[room_inventory]"
                       "([room_id]"
                       ",[inventory_id])"
                       "VALUES"
                       "(?,?)");
        _query.addBindValue(_newId);
        _query.addBindValue(i);
        if (!_query.exec()) {
            qDebug() << QSqlDatabase::database().lastError().text();
            return false;
        }
    }
    this->populate();
    return true;
}

bool RoomSqlModel::updateRoom(int index, const QString &name, int roomTypeId, bool needClean, bool locked, const QString &description, const QList<int> inventoryItems)
{
    QSqlQuery _query;
    auto _record = this->record(index);
    int _currentRecordId = _record.field("id").value().toInt();
    //step1
    _query.prepare("UPDATE [dbo].[room]"
                   "SET [name] = ?"
                   ",[room_type_id] = ?"
                   ",[need_clean] = ?"
                   ",[locked] = ?"
                   ",[description] = ? WHERE id = ?");
    _query.addBindValue(name);
    _query.addBindValue(roomTypeId);
    _query.addBindValue(needClean);
    _query.addBindValue(locked);
    _query.addBindValue(description);
    _query.addBindValue(_currentRecordId);
    if (!_query.exec()) {
        qDebug() << QSqlDatabase::database().lastError().text();
        return false;
    }
    //step2
    _query.prepare("DELETE FROM [dbo].[room_inventory] WHERE room_id = ?");
    _query.addBindValue(_currentRecordId);
    if (!_query.exec()) {
        qDebug() << QSqlDatabase::database().lastError().text();
        return false;
    }
    //step3

    for (int i: inventoryItems) {
        _query.prepare("INSERT INTO [dbo].[room_inventory]"
                       "([room_id]"
                       ",[inventory_id])"
                       "VALUES"
                       "(?,?)");
        _query.addBindValue(_currentRecordId);
        _query.addBindValue(i);
        if (!_query.exec()) {
            qDebug() << QSqlDatabase::database().lastError().text();
            return false;
        }
    }
    this->populate();
    return true;
}

RoomDto *RoomSqlModel::get(int index)
{
    RoomDto *r = new RoomDto;
    auto record = this->record(index);
    r->setId(record.field("id").value().toInt());
    r->setName(record.field("name").value().toString());
    r->setDescription(record.field("description").value().toString());
    r->setLocked(record.field("locked").value().toBool());
    r->setNeedClean(record.field("need_clean").value().toBool());
    r->setRoomTypeId(record.field("room_type_id").value().toInt());
    return r;
}
