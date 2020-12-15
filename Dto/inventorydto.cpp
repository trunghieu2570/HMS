#include "inventorydto.h"

InventoryDto::InventoryDto(QObject *parent)
{

}

QString InventoryDto::getName() const
{
    return name;
}

void InventoryDto::setName(const QString &value)
{
    name = value;
}
