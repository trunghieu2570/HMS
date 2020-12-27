#ifndef ROOMSQLMODEL_H
#define ROOMSQLMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlQuery>
#include "Dto/roomdto.h"
#include <QSqlField>
#include "Models/sqlquerymodel.h"

class RoomSqlModel : public SqlQueryModel
{
    Q_OBJECT

public:
    explicit RoomSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void populate();
    Q_INVOKABLE bool addRoom(const QString &name, int roomTypeId, bool needClean, bool locked, const QString &description, const QList<int> inventoryItems);
    Q_INVOKABLE bool updateRoom(int index, const QString &name, int roomTypeId, bool needClean, bool locked, const QString &description, const QList<int> inventoryItems);
    Q_INVOKABLE RoomDto *get(int index);
    //Q_INVOKABLE void addRow();
    //Q_INVOKABLE
};

#endif // ROOMSQLMODEL_H
