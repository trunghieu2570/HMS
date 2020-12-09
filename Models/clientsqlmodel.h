#ifndef CLIENTSQLMODEL_H
#define CLIENTSQLMODEL_H

#include <QSqlQueryModel>
#include <QSqlRecord>

class ClientSqlModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit ClientSqlModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    void populate();
private:
};

#endif // CLIENTSQLMODEL_H
