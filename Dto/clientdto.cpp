#include "clientdto.h"

QString ClientDto::getName() const
{
    return name;
}

void ClientDto::setName(const QString &value)
{
    name = value;
}

QDate ClientDto::getBirthday() const
{
    return birthday;
}

void ClientDto::setBirthday(const QDate &value)
{
    birthday = value;
}

bool ClientDto::getGender() const
{
    return gender;
}

void ClientDto::setGender(bool value)
{
    gender = value;
}

QString ClientDto::getEmail() const
{
    return email;
}

void ClientDto::setEmail(const QString &value)
{
    email = value;
}

QString ClientDto::getAddress() const
{
    return address;
}

void ClientDto::setAddress(const QString &value)
{
    address = value;
}

QString ClientDto::getPhoneNumber() const
{
    return phoneNumber;
}

void ClientDto::setPhoneNumber(const QString &value)
{
    phoneNumber = value;
}

QString ClientDto::getNationality() const
{
    return nationality;
}

void ClientDto::setNationality(const QString &value)
{
    nationality = value;
}

QString ClientDto::getIdentityNumber() const
{
    return identityNumber;
}

void ClientDto::setIdentityNumber(const QString &value)
{
    identityNumber = value;
}

QString ClientDto::getComments() const
{
    return comments;
}

void ClientDto::setComments(const QString &value)
{
    comments = value;
}

QString ClientDto::getId() const
{
    return id;
}

void ClientDto::setId(const QString &value)
{
    id = value;
}

ClientDto::ClientDto(QObject *parent): QObject(parent)
{
    
}
