#ifndef RESERVATIONSQLMODEL_H
#define RESERVATIONSQLMODEL_H

#include <Models/sqlquerymodel.h>
#include <Dto/reservationdto.h>

class ReservationSqlModel: public SqlQueryModel
{
    Q_OBJECT
public:
    explicit ReservationSqlModel(QObject *parent = nullptr);
    Q_INVOKABLE void populate();
    Q_INVOKABLE ReservationDto* get(int id);
};

#endif // RESERVATIONSQLMODEL_H
