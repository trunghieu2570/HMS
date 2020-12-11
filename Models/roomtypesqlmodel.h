#ifndef ROOMTYPESQLMODEL_H
#define ROOMTYPESQLMODEL_H


#include <QSqlQueryModel>
#include <QSqlRecord>

class RoomTypeSqlModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit RoomTypeSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    void populate();
private:
};

#endif // ROOMTYPESQLMODEL_H
