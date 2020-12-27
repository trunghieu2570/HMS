#include "roominventorysqlmodel.h"



RoomInventorySqlModel::RoomInventorySqlModel(QObject *parent)
{

}

void RoomInventorySqlModel::populate(int index)
{
    QSqlQuery _query;
    _query.prepare("SELECT [inventory_id] "
                   "FROM [room_inventory] "
                   "WHERE room_id = :id");
    _query.bindValue(":id", index);
    _query.exec();
    setQuery(_query);
}

QList<int> RoomInventorySqlModel::getList()
{
    QList<int> list;
    list.clear();
    for(int i = 0; i < this->rowCount(); i++) {
        list.append(this->data(this->index(i, 0)).toInt());
    }
    return list;
}
