#include "useraccountdto.h"

QString UserAccountDto::getUsername() const
{
    return username;
}

void UserAccountDto::setUsername(const QString &value)
{
    username = value;
}

QString UserAccountDto::getName() const
{
    return name;
}

void UserAccountDto::setName(const QString &value)
{
    name = value;
}

int UserAccountDto::getRole() const
{
    return role;
}

void UserAccountDto::setRole(int value)
{
    role = value;
}

bool UserAccountDto::getGender() const
{
    return gender;
}

void UserAccountDto::setGender(bool value)
{
    gender = value;
}

QDate UserAccountDto::getBirthday() const
{
    return birthday;
}

void UserAccountDto::setBirthday(const QDate &value)
{
    birthday = value;
}

QString UserAccountDto::getEmail() const
{
    return email;
}

void UserAccountDto::setEmail(const QString &value)
{
    email = value;
}

QString UserAccountDto::getAddress() const
{
    return address;
}

void UserAccountDto::setAddress(const QString &value)
{
    address = value;
}

QString UserAccountDto::getPhoneNumber() const
{
    return phoneNumber;
}

void UserAccountDto::setPhoneNumber(const QString &value)
{
    phoneNumber = value;
}

int UserAccountDto::getId() const
{
    return id;
}

void UserAccountDto::setId(int value)
{
    id = value;
}

UserAccountDto::UserAccountDto(QObject *parent): QObject(parent)
{

}
