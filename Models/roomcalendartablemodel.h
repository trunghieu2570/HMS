#ifndef ROOMCALENDARTABLEMODEL_H
#define ROOMCALENDARTABLEMODEL_H


#include <qqml.h>
#include <QAbstractTableModel>
#include <QSqlQueryModel>
#include <QDate>

class RoomCalendarTableModel : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_ADDED_IN_MINOR_VERSION(1)
private:
    QSqlQueryModel roomModel;
    QVector<QVariantMap> vector;
    int vectorIndex(int x, int y) const;

public:
    explicit RoomCalendarTableModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    int columnCount(const QModelIndex & = QModelIndex()) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override ;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void populate(int month = QDate::currentDate().month(), int year = QDate::currentDate().year());
    QHash<int, QByteArray> roleNames() const override
    {
        return { {Qt::DisplayRole, "display"} };
    }
};

#endif // ROOMCALENDARTABLEMODEL_H
