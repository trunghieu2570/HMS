#ifndef USERACCOUNTSQLMODEL_H
#define USERACCOUNTSQLMODEL_H

#include <Models/sqlquerymodel.h>

class UserAccountSqlModel : public SqlQueryModel
{
    Q_OBJECT
public:
    explicit UserAccountSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void populate();
};

#endif // USERACCOUNTSQLMODEL_H
