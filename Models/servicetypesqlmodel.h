#ifndef SERVICETYPESQLMODEL_H
#define SERVICETYPESQLMODEL_H
#include "sqlquerymodel.h"
#include "Dto/servicetypedto.h"

class ServiceTypeSqlModel : public SqlQueryModel
{
    Q_OBJECT
public:
    explicit ServiceTypeSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE bool add(const QString &name,
                         const QString &description,
                         qint64 base_price);
    Q_INVOKABLE bool update(int index,
                            const QString &name,
                            const QString &description,
                            qint64 base_price);
    Q_INVOKABLE bool remove(int index);
    Q_INVOKABLE ServiceTypeDto *get(int index);
    Q_INVOKABLE void populate();
    //Q_INVOKABLE RoomTypeDto *get(int index);
private:
};

#endif // SERVICETYPESQLMODEL_H
