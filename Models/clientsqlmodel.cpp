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
                return tr("Phone Number");
            case 6:
                return tr("Nationality");
            case 7:
                return tr("Identity Number");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

void ClientSqlModel::populate()
{
    setQuery("SELECT [Id], [Name], [Birthday], [Gender], [Email], [PhoneNumber], [Nationality], [IdentityNumber] FROM Client");
}
