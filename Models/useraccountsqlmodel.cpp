#include "useraccountsqlmodel.h"
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlField>
#include <QImage>
#include <QUrl>
#include <QFile>
#include <QDebug>

UserAccountSqlModel::UserAccountSqlModel(QObject *parent): SqlQueryModel(parent)
{

}

QVariant UserAccountSqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("Mã NV");
            case 1:
                return tr("Ảnh");
            case 2:
                return tr("Tên người dùng");
            case 3:
                return tr("Họ và tên");
            case 4:
                return tr("Chức vụ");
            case 5:
                return tr("Giới tính");
            case 6:
                return tr("Ngày sinh");
            case 7:
                return tr("Email");
            case 8:
                return tr("Địa chỉ");
            case 9:
                return tr("Số điện thoại");
            case 10:
                return tr("Ghi chú");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

void UserAccountSqlModel::populate()
{
    setQuery("SELECT [id]"
             ",[avatar]"
             ",[username]"
             ",[name]"
             ",[role]"
             ",[gender]"
             ",[birthday]"
             ",[email]"
             ",[address]"
             ",[phone_number]"
             ",[comments]"
             "FROM [dbo].[user_account] WHERE deleted <> 1");
}

bool UserAccountSqlModel::add(const QUrl &avatar, const QString &username, const QString &pass, const QString &name, int role, bool gender, const QDate &birthday, const QString &email, const QString &address, const QString &phoneNumber)
{
    QSqlQuery _query;
    _query.prepare("INSERT INTO [dbo].[user_account]"
                   "([name]"
                   ",[birthday]"
                   ",[gender]"
                   ",[email]"
                   ",[address]"
                   ",[phone_number]"
                   ",[role]"
                   ",[username]"
                   ",[pass]"
                   ",[deleted])"
                   "VALUES (?,?,?,?,?,?,?,?,HASHBYTES('SHA2_256', ?),?)");
    _query.addBindValue(name);
    _query.addBindValue(birthday);
    _query.addBindValue(gender);
    _query.addBindValue(email);
    _query.addBindValue(address);
    _query.addBindValue(phoneNumber);
    _query.addBindValue(role);
    _query.addBindValue(username);
    _query.addBindValue(pass);
    _query.addBindValue(0);
    if (!_query.exec()) return false;

    if (!avatar.isEmpty() && avatar.scheme() == "file") {
        _query.prepare("UPDATE [dbo].[user_account] SET [avatar] = ? WHERE id = ?");
        QFile avtFile(avatar.toLocalFile());
        avtFile.open(QIODevice::ReadOnly);
        _query.addBindValue(avtFile.readAll());
        _query.addBindValue(_query.lastInsertId().toInt());
        _query.exec();
    }
    this->populate();
    return true;
}

bool UserAccountSqlModel::update(int id, const QUrl &avatar, const QString &pass, const QString &name, int role, bool gender, const QDate &birthday, const QString &email, const QString &address, const QString &phoneNumber)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[user_account]"
                   "SET [name] = ?"
                   ",[birthday] = ?"
                   ",[gender] = ?"
                   ",[email] = ?"
                   ",[address] = ?"
                   ",[phone_number] = ?"
                   ",[role] = ? WHERE id = ?");
    _query.addBindValue(name);
    _query.addBindValue(birthday);
    _query.addBindValue(gender);
    _query.addBindValue(email);
    _query.addBindValue(address);
    _query.addBindValue(phoneNumber);
    _query.addBindValue(role);
    _query.addBindValue(id);
    if (!_query.exec()) return false;

    if (!avatar.isEmpty() && avatar.scheme() != "image")
    {
        _query.prepare("UPDATE [dbo].[user_account] SET [avatar] = ? WHERE id = ?");
        QFile avtFile(avatar.toLocalFile());
        avtFile.open(QIODevice::ReadOnly);
        _query.addBindValue(avtFile.readAll());
        _query.addBindValue(id);
        qDebug() << _query.exec();

    }
    if (pass != "")
    {
        _query.prepare("UPDATE [dbo].[user_account] SET [pass] = HASHBYTES('SHA2_256', ?) WHERE id = ?");
        _query.addBindValue(pass);
        _query.addBindValue(id);
        qDebug() << _query.exec();
    }

    this->populate();
    return true;
}

UserAccountDto *UserAccountSqlModel::get(int index)
{
    UserAccountDto *user = new UserAccountDto;
    QSqlRecord _record = this->record(index);
    user->setAddress(_record.field("address").value().toString());
    user->setBirthday(_record.field("birthday").value().toDate());
    user->setEmail(_record.field("email").value().toString());
    user->setGender(_record.field("gender").value().toBool());
    user->setId(_record.field("id").value().toInt());
    user->setName(_record.field("name").value().toString());
    user->setPhoneNumber(_record.field("phone_number").value().toString());
    user->setRole(_record.field("role").value().toInt());
    user->setUsername(_record.field("username").value().toString());
    return user;
}

bool UserAccountSqlModel::remove(int index)
{
    QSqlQuery _query;
    _query.prepare("UPDATE [dbo].[user_account] SET deleted = ? WHERE id = ?");
    _query.addBindValue(1);
    auto record = this->record(index);
    _query.addBindValue(record.field("id").value().toInt());
    bool r = _query.exec();
    if (r) this->populate();
    return r;
}
