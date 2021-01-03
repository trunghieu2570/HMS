#include "clientsqlmodel.h"
#include <QSqlRecord>
#include <QSqlField>

ClientSqlModel::ClientSqlModel(QObject *parent)
    : SqlQueryModel(parent)
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

bool ClientSqlModel::addRow(const QString &name, const QDate &birthday, bool gender, const QString &email, const QString &address, const QString &phoneNumber, const QString &nationality, const QString &identityNumber, const QString &comments)
{
    QSqlQuery _query;
    _query.prepare("INSERT INTO [dbo].[client]"
                   "([name]"
                   ",[birthday]"
                   ",[gender]"
                   ",[email]"
                   ",[address]"
                   ",[phone_number]"
                   ",[nationality]"
                   ",[identity_number]"
                   ",[comments]"
                   ",[deleted])"
                   "VALUES (?,?,?,?,?,?,?,?,?,?)");
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

bool ClientSqlModel::updateRow(int id, const QString &name, const QDate &birthday, bool gender, const QString &email, const QString &address, const QString &phoneNumber, const QString &nationality, const QString &identityNumber, const QString &comments)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[client]"
                   "SET [name] = ?"
                   ",[birthday] = ?"
                   ",[gender] = ?"
                   ",[email] = ?"
                   ",[address] = ?"
                   ",[phone_number] = ?"
                   ",[nationality] = ?"
                   ",[identity_number] = ?"
                   ",[comments] = ? WHERE id = ?");
    QSqlRecord rec = this->record(id);
    _query.addBindValue(name);
    _query.addBindValue(birthday);
    _query.addBindValue(gender);
    _query.addBindValue(email);
    _query.addBindValue(address);
    _query.addBindValue(phoneNumber);
    _query.addBindValue(nationality);
    _query.addBindValue(identityNumber);
    _query.addBindValue(comments);
    _query.addBindValue(rec.value("id").toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

bool ClientSqlModel::deleteRow(int id)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[client] SET deleted = ? WHERE id = ?");
    _query.addBindValue(1);
    auto record = this->record(id);
    _query.addBindValue(record.field("id").value().toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}

ClientDto* ClientSqlModel::get(int index)
{
    ClientDto *r = new ClientDto;
    auto record = this->record(index);
    r->setName(record.field("name").value().toString());
    r->setAddress(record.field("address").value().toString());
    r->setBirthday(record.field("birthday").value().toDate());
    r->setComments(record.field("comments").value().toString());
    r->setEmail(record.field("email").value().toString());
    r->setGender(record.field("gender").value().toBool());
    r->setIdentityNumber(record.field("identity_number").value().toString());
    r->setNationality(record.field("nationality").value().toString());
    r->setPhoneNumber(record.field("phone_number").value().toString());
    return r;
}
