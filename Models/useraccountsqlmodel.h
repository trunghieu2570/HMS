#ifndef USERACCOUNTSQLMODEL_H
#define USERACCOUNTSQLMODEL_H

#include <Models/sqlquerymodel.h>
#include "Dto/useraccountdto.h"

class UserAccountSqlModel : public SqlQueryModel
{
    Q_OBJECT
public:
    explicit UserAccountSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void populate();
    Q_INVOKABLE bool add(
            const QUrl &avatar,
            const QString &username,
            const QString &pass,
            const QString &name,
            int role,
            bool gender,
            const QDate &birthday,
            const QString &email,
            const QString &address,
            const QString &phoneNumber);
    Q_INVOKABLE bool update(int id,
                            const QUrl &avatar,
                            const QString &pass,
                            const QString &name,
                            int role,
                            bool gender,
                            const QDate &birthday,
                            const QString &email,
                            const QString &address,
                            const QString &phoneNumber);
    Q_INVOKABLE UserAccountDto* get(int index);
    Q_INVOKABLE bool remove(int index);
};

#endif // USERACCOUNTSQLMODEL_H
