#ifndef CLIENTDTO_H
#define CLIENTDTO_H

#include <QObject>
#include <QDate>


class ClientDto: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ getId CONSTANT)
    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(QDate birthday READ getBirthday WRITE setBirthday)
    Q_PROPERTY(bool gender READ getGender WRITE setGender)
    Q_PROPERTY(QString email READ getEmail WRITE setEmail)
    Q_PROPERTY(QString address READ getAddress WRITE setAddress)
    Q_PROPERTY(QString phoneNumber READ getPhoneNumber WRITE setPhoneNumber)
    Q_PROPERTY(QString nationality READ getNationality WRITE setNationality)
    Q_PROPERTY(QString identityNumber READ getIdentityNumber WRITE setIdentityNumber)
    Q_PROPERTY(QString comments READ getComments WRITE setComments)

private:
    QString id;
    QString name;
    QDate birthday;
    bool gender;
    QString email;
    QString address;
    QString phoneNumber;
    QString nationality;
    QString identityNumber;
    QString comments;

public:
    ClientDto(QObject *parent = nullptr);
    QString getName() const;
    void setName(const QString &value);
    QDate getBirthday() const;
    void setBirthday(const QDate &value);
    bool getGender() const;
    void setGender(bool value);
    QString getEmail() const;
    void setEmail(const QString &value);
    QString getAddress() const;
    void setAddress(const QString &value);
    QString getPhoneNumber() const;
    void setPhoneNumber(const QString &value);
    QString getNationality() const;
    void setNationality(const QString &value);
    QString getIdentityNumber() const;
    void setIdentityNumber(const QString &value);
    QString getComments() const;
    void setComments(const QString &value);
    QString getId() const;
    void setId(const QString &value);
};

#endif // CLIENTDTO_H
