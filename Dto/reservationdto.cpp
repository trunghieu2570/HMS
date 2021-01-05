#include "reservationdto.h"

int ReservationDto::getRoomId() const
{
    return roomId;
}

void ReservationDto::setRoomId(int value)
{
    roomId = value;
}

QDate ReservationDto::getCheckin() const
{
    return checkin;
}

void ReservationDto::setCheckin(const QDate &value)
{
    checkin = value;
}

QDate ReservationDto::getCheckout() const
{
    return checkout;
}

void ReservationDto::setCheckout(const QDate &value)
{
    checkout = value;
}

int ReservationDto::getClientId() const
{
    return clientId;
}

void ReservationDto::setClientId(int value)
{
    clientId = value;
}

qint64 ReservationDto::getRoomPrice() const
{
    return roomPrice;
}

void ReservationDto::setRoomPrice(const qint64 &value)
{
    roomPrice = value;
}

qint64 ReservationDto::getDiscount() const
{
    return discount;
}

void ReservationDto::setDiscount(const qint64 &value)
{
    discount = value;
}

int ReservationDto::getState() const
{
    return state;
}

void ReservationDto::setState(int value)
{
    state = value;
}

QString ReservationDto::getNote() const
{
    return note;
}

void ReservationDto::setNote(const QString &value)
{
    note = value;
}

int ReservationDto::getUserAccountId() const
{
    return userAccountId;
}

void ReservationDto::setUserAccountId(int value)
{
    userAccountId = value;
}

QDateTime ReservationDto::getCreateDate() const
{
    return createDate;
}

void ReservationDto::setCreateDate(const QDateTime &value)
{
    createDate = value;
}

QString ReservationDto::getUserAccountName() const
{
    return userAccountName;
}

void ReservationDto::setUserAccountName(const QString &value)
{
    userAccountName = value;
}

ReservationDto::ReservationDto(QObject *parent) : QObject(parent)
{

}
