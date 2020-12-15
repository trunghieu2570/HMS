#include "roomtypedto.h"


int RoomTypeDto::getSingleBeds() const
{
    return singleBeds;
}

void RoomTypeDto::setSingleBeds(int value)
{
    singleBeds = value;
}

int RoomTypeDto::getDoubleBeds() const
{
    return doubleBeds;
}

void RoomTypeDto::setDoubleBeds(int value)
{
    doubleBeds = value;
}

int RoomTypeDto::getGuests() const
{
    return guests;
}

void RoomTypeDto::setGuests(int value)
{
    guests = value;
}

qint64 RoomTypeDto::getPrice() const
{
    return price;
}

void RoomTypeDto::setPrice(const qint64 &value)
{
    price = value;
}

qint64 RoomTypeDto::getSurcharge() const
{
    return surcharge;
}

void RoomTypeDto::setSurcharge(const qint64 &value)
{
    surcharge = value;
}

QString RoomTypeDto::getDescription() const
{
    return description;
}

void RoomTypeDto::setDescription(const QString &value)
{
    description = value;
}

RoomTypeDto::RoomTypeDto(QObject *parent)
{

}

QString RoomTypeDto::getName() const
{
    return name;
}

void RoomTypeDto::setName(const QString &value)
{
    name = value;
}
