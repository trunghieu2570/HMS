#include "servicetypedto.h"

QString ServiceTypeDto::getDescription() const
{
    return description;
}

void ServiceTypeDto::setDescription(const QString &value)
{
    description = value;
}

ServiceTypeDto::ServiceTypeDto(QObject *parent): QObject(parent)
{

}

QString ServiceTypeDto::getName() const
{
    return name;
}

void ServiceTypeDto::setName(const QString &value)
{
    name = value;
}

qint64 ServiceTypeDto::getBasePrice() const
{
    return basePrice;
}

void ServiceTypeDto::setBasePrice(const qint64 &value)
{
    basePrice = value;
}
