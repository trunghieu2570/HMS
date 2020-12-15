#include "clientsqlmodel.h"

ClientSqlModel::ClientSqlModel(QObject *parent)
    : QSqlQueryModel(parent)
{
}

QVariant ClientSqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("Client ID");
            case 1:
                return tr("Name");
            case 2:
                return tr("Birthday");
            case 3:
                return tr("Gender");
            case 4:
                return tr("Email");
            case 5:
                return tr("Address");
            case 6:
                return tr("Phone Number");
            case 7:
                return tr("Nationality");
            case 8:
                return tr("Identity Number");
            case 9:
                return tr("Comments");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

void ClientSqlModel::populate(const QString &keyword)
{
    setQuery(
                "SELECT TOP (1000) [id]"
                ",[name]"
                ",[birthday]"
                ",[gender]"
                ",[email]"
                ",[address]"
                ",[phone_number]"
                ",[nationality]"
                ",[identity_number]"
                ",[comments]"
                "FROM [HOTEL_DATABASE].[dbo].[client]"
                "WHERE [deleted] <> 1"
                );
}

bool ClientSqlModel::addRow(const QString &id, const QString &name, const QDate &birthday, bool gender, const QString &email, const QString &address, const QString &phoneNumber, const QString &nationality, const QString &identityNumber, const QString &comments)
{
    QSqlQuery _query;
    _query.prepare("INSERT INTO [dbo].[client]"
              "([id]"
              ",[name]"
              ",[birthday]"
              ",[gender]"
              ",[email]"
              ",[address]"
              ",[phone_number]"
              ",[nationality]"
              ",[identity_number]"
              ",[comments]"
              ",[deleted])"
              "VALUES (?,?,?,?,?,?,?,?,?,?,?)");
    _query.addBindValue(id);
    _query.addBindValue(name);
    _query.addBindValue(birthday);
    _query.addBindValue(gender);
    _query.addBindValue(email);
    _query.addBindValue(address);
    _query.addBindValue(phoneNumber);
    _query.addBindValue(nationality);
    _query.addBindValue(identityNumber);
    _query.addBindValue(comments);
    _query.addBindValue(0);
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}
