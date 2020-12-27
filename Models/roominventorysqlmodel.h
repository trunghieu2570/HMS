#ifndef ROOMINVENTORYSQLMODEL_H
#define ROOMINVENTORYSQLMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlField>

class RoomInventorySqlModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit RoomInventorySqlModel(QObject *parent = nullptr);
    Q_INVOKABLE void populate(int index = 0);
    Q_INVOKABLE QList<int> getList();
};

#endif // ROOMINVENTORYSQLMODEL_H
