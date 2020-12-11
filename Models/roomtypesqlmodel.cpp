#include "roomtypesqlmodel.h"


RoomTypeSqlModel::RoomTypeSqlModel(QObject *parent)
{

}

QVariant RoomTypeSqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("ID");
            case 1:
                return tr("Name");
            case 2:
                return tr("Single Beds");
            case 3:
                return tr("Double Beds");
            case 4:
                return tr("Price");
            case 5:
                return tr("Surcharge");
            case 6:
                return tr("Guest");
            case 7:
                return tr("Description");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

void RoomTypeSqlModel::populate()
{
     setQuery("SELECT [id]"
              ",[name]"
              ",[single_beds]"
              ",[double_beds]"
              ",[price]"
              ",[surcharge]"
              ",[guests]"
              ",[description]"
          "FROM [HOTEL_DATABASE].[dbo].[room_type]");
}
