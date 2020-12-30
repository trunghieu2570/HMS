#ifndef AUTHENTICATIONSERVICE_H
#define AUTHENTICATIONSERVICE_H

#include <QObject>

class AuthenticationService : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int currentUserId READ getCurrentUserId NOTIFY stateChanged)
    Q_PROPERTY(int currentUserRole READ getCurrentUserRole)
    Q_PROPERTY(QString currentUserName READ getCurrentUserName)
private:
    static AuthenticationService* instance;
    int currentUserId = -1;
    int currentUserRole = -1;
    QString currentUserName;
    explicit AuthenticationService(QObject *parent = nullptr);
public:
    Q_INVOKABLE int login(const QString username, const QString password);
    Q_INVOKABLE void logout();
    int getCurrentUserId() const;
\
    static AuthenticationService *getInstance();

    int getCurrentUserRole() const;

    QString getCurrentUserName() const;

signals:
    void stateChanged();
    void loggedOut();
};

#endif // AUTHENTICATIONSERVICE_H
