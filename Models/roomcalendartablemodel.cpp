#include "roomcalendartablemodel.h"
#include <QSqlQuery>
#include <QSqlField>
#include <QSqlResult>
#include <QSqlRecord>

RoomCalendarTableModel::RoomCalendarTableModel(QObject *parent): QAbstractTableModel(parent)
{
}

int RoomCalendarTableModel::rowCount(const QModelIndex &) const
{
    return roomModel.rowCount();
}

int RoomCalendarTableModel::columnCount(const QModelIndex &) const
{
    return QDate::currentDate().daysInMonth();
}

QVariant RoomCalendarTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(role == Qt::DisplayRole) {
        if(orientation == Qt::Orientation::Horizontal) {
            return section+1;
        } else {
            return section;
        }
    }
    return QVariant();
}

QVariant RoomCalendarTableModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case Qt::DisplayRole:
        return vector[vectorIndex(index.column(), index.row())];
    }
    return QVariant();
}

void RoomCalendarTableModel::populate(int month, int year)
{
    roomModel.setQuery("SELECT [id]"
                       ",[name]"
                       "FROM [room] WHERE deleted <> 1");
    vector.clear();
    vector.resize(rowCount() * columnCount());
    qDebug() << rowCount();
    for(int i = 0; i < rowCount(); i++) {
        QSqlQueryModel tmpModel;
        QSqlQuery mainQuery;
        mainQuery.prepare("select r.[id], [state], c.[name], r.[check_in], r.[check_out]"
                          "from [reservation] r join [client] c on r.client_id = c.id where r.room_id = ?");
        mainQuery.addBindValue(roomModel.data(roomModel.index(i, 0)).toInt());
        mainQuery.exec();
        tmpModel.setQuery(mainQuery);

        for(int j = 0; j < columnCount(); j++) {
            QDate date(year, month, j+1);
            for(int current = 0; current < tmpModel.rowCount(); current++) {
                QDate checkin = tmpModel.data(tmpModel.index(current, 3)).toDate();
                QDate checkout = tmpModel.data(tmpModel.index(current, 4)).toDate();
                if(checkin <= date && date <= checkout) {
                    QVariantMap map;
                    map.insert("id", tmpModel.data(tmpModel.index(current, 0)).toString());
                    map.insert("state", tmpModel.data(tmpModel.index(current, 1)).toInt());
                    map.insert("name", tmpModel.data(tmpModel.index(current, 2)).toString());
                    map.insert("check_in", tmpModel.data(tmpModel.index(current, 3)).toDate());
                    map.insert("check_out", tmpModel.data(tmpModel.index(current, 4)).toDate());
                    qDebug() << vectorIndex(j,i);
                    vector[vectorIndex(j,i)] = map;
                }
            }
        }
    }

    //    for(int i = 0; i < rowCount(); i++) {
    //        qDebug() << roomModel.data(roomModel.index(i, 1));
    //        for(int j = 0; j < columnCount(); j++) {
    //            qDebug() << j+1;
    //             qDebug() <<  data(index(i,j));
    //        }
    //    }
}

int RoomCalendarTableModel::vectorIndex(int x, int y) const {
    return x + columnCount() * y;
}
