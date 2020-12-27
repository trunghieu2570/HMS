#include "roomdto.h"

QString RoomDto::getName() const
{
    return name;
}

void RoomDto::setName(const QString &value)
{
    name = value;
}

int RoomDto::getRoomTypeId() const
{
    return roomTypeId;
}

void RoomDto::setRoomTypeId(int value)
{
    roomTypeId = value;
}

bool RoomDto::getNeedClean() const
{
    return needClean;
}

void RoomDto::setNeedClean(bool value)
{
    needClean = value;
}

bool RoomDto::getLocked() const
{
    return locked;
}

void RoomDto::setLocked(bool value)
{
    locked = value;
}

QString RoomDto::getDescription() const
{
    return description;
}

void RoomDto::setDescription(const QString &value)
{
    description = value;
}

int RoomDto::getId() const
{
    return id;
}

void RoomDto::setId(int value)
{
    id = value;
}

RoomDto::RoomDto(QObject *parent): QObject(parent)
{
    
}
