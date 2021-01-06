#include "servicesqlmodel.h"

ServiceSqlModel::ServiceSqlModel(QObject *parent): SqlQueryModel(parent)
{

}

QVariant ServiceSqlModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("Mã DV");
            case 1:
                return tr("Dịch vụ");
            case 2:
                return tr("Phòng");
            case 3:
                return tr("Ngày");
            case 4:
                return tr("Khách hàng");
            case 5:
                return tr("Nội dung");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

void ServiceSqlModel::populate()
{
    setQuery("SELECT s.service_type_id, st.name as service_type, rm.name as room, r.check_in, c.name as client, s.description FROM [dbo].[use_service_detail] s JOIN [dbo].[service_type] st ON s.service_type_id = st.id JOIN (SELECT * FROM [dbo].[reservation] WHERE deleted <> 1) r ON s.reservation_id = r.id JOIN [dbo].[client] c ON r.client_id = c.id JOIN [dbo].[room] rm ON r.room_id = rm.id");
}
