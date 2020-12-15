#ifndef ROOMTYPEDTO_H
#define ROOMTYPEDTO_H

#include <QObject>

class RoomTypeDto : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(int singleBeds READ getSingleBeds WRITE setSingleBeds)
    Q_PROPERTY(int doubleBeds READ getDoubleBeds WRITE setDoubleBeds)
    Q_PROPERTY(int guests READ getGuests WRITE setGuests)
    Q_PROPERTY(qint64 price READ getPrice WRITE setPrice)
    Q_PROPERTY(qint64 surcharge READ getSurcharge WRITE setSurcharge)
    Q_PROPERTY(QString description READ getDescription WRITE setDescription)

private:
    QString name;
    int singleBeds;
    int doubleBeds;
    int guests;
    qint64 price;
    qint64 surcharge;
    QString description;

public:
    explicit RoomTypeDto(QObject *parent = nullptr);
    QString getName() const;
    void setName(const QString &value);

    int getSingleBeds() const;
    void setSingleBeds(int value);

    int getDoubleBeds() const;
    void setDoubleBeds(int value);

    int getGuests() const;
    void setGuests(int value);

    qint64 getPrice() const;
    void setPrice(const qint64 &value);

    qint64 getSurcharge() const;
    void setSurcharge(const qint64 &value);

    QString getDescription() const;
    void setDescription(const QString &value);

signals:

};

#endif // ROOMTYPEDTO_H
