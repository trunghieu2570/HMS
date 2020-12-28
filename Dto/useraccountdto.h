#ifndef USERACCOUNTDTO_H
#define USERACCOUNTDTO_H

#include <QObject>
#include <QBitArray>
#include <QDate>

class UserAccountDto: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ getId WRITE setId)
    Q_PROPERTY(QString username READ getUsername WRITE setUsername)
    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(int role READ getRole WRITE setRole)
    Q_PROPERTY(bool gender READ getGender WRITE setGender)
    Q_PROPERTY(QDate birthday READ getBirthday WRITE setBirthday)
    Q_PROPERTY(QString email READ getEmail WRITE setEmail)
    Q_PROPERTY(QString address READ getAddress WRITE setAddress)
    Q_PROPERTY(QString phoneNumber READ getPhoneNumber WRITE setPhoneNumber)

private:
    int id;
    QString username;
    QString name;
    int role;
    bool gender;
    QDate birthday;
    QString email;
    QString address;
    QString phoneNumber;
public:
    explicit UserAccountDto(QObject *parent = nullptr);
    QString getUsername() const;
    void setUsername(const QString &value);
    QString getName() const;
    void setName(const QString &value);
    int getRole() const;
    void setRole(int value);
    bool getGender() const;
    void setGender(bool value);
    QDate getBirthday() const;
    void setBirthday(const QDate &value);
    QString getEmail() const;
    void setEmail(const QString &value);
    QString getAddress() const;
    void setAddress(const QString &value);
    QString getPhoneNumber() const;
    void setPhoneNumber(const QString &value);
    int getId() const;
    void setId(int value);
};

#endif // USERACCOUNTDTO_H
