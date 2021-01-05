#ifndef RESERVATIONDTO_H
#define RESERVATIONDTO_H

#include <QObject>
#include <QDate>

class ReservationDto : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int roomId READ getRoomId WRITE setRoomId)
    Q_PROPERTY(QDate checkin READ getCheckin WRITE setCheckin)
    Q_PROPERTY(QDate checkout READ getCheckout WRITE setCheckout)
    Q_PROPERTY(int clientId READ getClientId WRITE setClientId)
    Q_PROPERTY(qint64 roomPrice READ getRoomPrice WRITE setRoomPrice)
    Q_PROPERTY(qint64 discount READ getDiscount WRITE setDiscount)
    Q_PROPERTY(int state READ getState WRITE setState)
    Q_PROPERTY(QString note READ getNote WRITE setNote)
    Q_PROPERTY(int userAccountId READ getUserAccountId WRITE setUserAccountId)
    Q_PROPERTY(QString userAccountName READ getUserAccountName WRITE setUserAccountName)
    Q_PROPERTY(QDateTime createDate READ getCreateDate WRITE setCreateDate)

private:
    int roomId;
    QDate checkin;
    QDate checkout;
    int clientId;
    qint64 roomPrice;
    qint64 discount;
    int state;
    QString note;
    int userAccountId;
    QString userAccountName;
    QDateTime createDate;
public:
    explicit ReservationDto(QObject *parent = nullptr);

    int getRoomId() const;
    void setRoomId(int value);

    QDate getCheckin() const;
    void setCheckin(const QDate &value);

    QDate getCheckout() const;
    void setCheckout(const QDate &value);

    int getClientId() const;
    void setClientId(int value);

    qint64 getRoomPrice() const;
    void setRoomPrice(const qint64 &value);

    qint64 getDiscount() const;
    void setDiscount(const qint64 &value);

    int getState() const;
    void setState(int value);

    QString getNote() const;
    void setNote(const QString &value);

    int getUserAccountId() const;
    void setUserAccountId(int value);

    QDateTime getCreateDate() const;
    void setCreateDate(const QDateTime &value);

    QString getUserAccountName() const;
    void setUserAccountName(const QString &value);

signals:

};

#endif // RESERVATIONDTO_H
