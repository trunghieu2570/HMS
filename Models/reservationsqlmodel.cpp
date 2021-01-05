#include "reservationsqlmodel.h"
#include <QSqlRecord>
#include <QSqlField>
#include <QSqlQuery>

ReservationSqlModel::ReservationSqlModel(QObject *parent): SqlQueryModel(parent)
{

}

void ReservationSqlModel::populate()
{
    setQuery("SELECT [id]"
             ",[room_id]"
             ",[check_in]"
             ",[check_out]"
             ",[client_id]"
             ",[room_price]"
             ",[discount]"
             ",[state]"
             ",[note]"
             ",[user_account_id]"
             ",[create_date]"
             "FROM [dbo].[reservation] WHERE deleted <> 1");
}

ReservationDto* ReservationSqlModel::get(int id)
{
    ReservationDto* dto = new ReservationDto;
    QSqlQuery q;
    q.prepare("SELECT * FROM [dbo].[reservation] WHERE id = ?");
    q.addBindValue(id);
    q.exec();
    while (q.next()) {
        dto->setCheckin(q.value("check_in").toDate());
        dto->setCheckout(q.value("check_out").toDate());
        dto->setClientId(q.value("client_id").toInt());
        dto->setDiscount(q.value("discount").toLongLong());
        dto->setCreateDate(q.value("create_date").toDateTime());
        dto->setNote(q.value("note").toString());
        dto->setRoomId(q.value("room_id").toInt());
        dto->setRoomPrice(q.value("room_price").toLongLong());
        dto->setState(q.value("state").toInt());
        dto->setUserAccountId(q.value("user_account_id").toInt());
    }
    return dto;
}
