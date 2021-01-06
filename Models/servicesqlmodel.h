#ifndef SERVICESQLMODEL_H
#define SERVICESQLMODEL_H

#include "Models/sqlquerymodel.h"

class ServiceSqlModel : public SqlQueryModel
{
    Q_OBJECT
public:
    explicit ServiceSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void populate();
};

#endif // SERVICESQLMODEL_H
