#include "authenticationservice.h"
#include <QDebug>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlField>

AuthenticationService* AuthenticationService::instance = nullptr;

int AuthenticationService::getCurrentUserId() const
{
    return currentUserId;
}

AuthenticationService *AuthenticationService::getInstance()
{
    if(instance == nullptr) {
        instance = new AuthenticationService();
    }
    return instance;
}

int AuthenticationService::getCurrentUserRole() const
{
    return currentUserRole;
}

QString AuthenticationService::getCurrentUserName() const
{
    return currentUserName;
}

AuthenticationService::AuthenticationService(QObject *parent) : QObject(parent)
{

}

int AuthenticationService::login(const QString username, const QString password)
{
    QSqlQuery query;
    query.prepare("SELECT [id], [role], [name]"
                  "FROM [dbo].[user_account] WHERE deleted <> 1 AND username = ? AND pass = HASHBYTES('SHA2_256', ?)");
    query.addBindValue(username);
    query.addBindValue(password);
    query.exec();
    query.next();
    if(!query.record().field("id").isNull()) {
        currentUserId = query.record().field("id").value().toInt();
        currentUserRole = query.record().field("role").value().toInt();
        currentUserName = query.record().field("name").value().toString();
    }
    qDebug() << currentUserId;
    return currentUserId;
}

void AuthenticationService::logout()
{
    currentUserId = -1;
    currentUserName = "";
    currentUserRole = -1;
    loggedOut();
}
