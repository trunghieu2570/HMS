#ifndef ROOMTYPESQLMODEL_H
#define ROOMTYPESQLMODEL_H


#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlQuery>
#include "Dto/roomtypedto.h"
#include <QSqlField>
#include "Models/sqlquerymodel.h"

class RoomTypeSqlModel : public SqlQueryModel
{
    Q_OBJECT

public:
    explicit RoomTypeSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE bool addRow(const QString &name,
                            const QString &sbed,
                            const QString &dbed,
                            const QString &guest,
                            const QString &description,
                            const QString &price,
                            const QString &surcharge);
    Q_INVOKABLE bool updateRow(int id,
                               const QString &name = nullptr,
                               const QString &sbed = nullptr,
                               const QString &dbed = nullptr,
                               const QString &guest = nullptr,
                               const QString &description = nullptr,
                               const QString &price = nullptr,
                               const QString &surcharge = nullptr);
    Q_INVOKABLE void populate();
    Q_INVOKABLE RoomTypeDto *get(int index);
    //Q_INVOKABLE QString getName
private:
};

#endif // ROOMTYPESQLMODEL_H
