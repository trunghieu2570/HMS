#ifndef CLIENTSQLMODEL_H
#define CLIENTSQLMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlQuery>

class ClientSqlModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit ClientSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void populate(const QString &keyword = nullptr);
    Q_INVOKABLE bool addRow(
            const QString &id,
            const QString &name,
            const QDate &birthday,
            bool gender,
            const QString &email,
            const QString &address,
            const QString &phoneNumber,
            const QString &nationality,
            const QString &identityNumber,
            const QString &comments);
private:
};

#endif // CLIENTSQLMODEL_H
