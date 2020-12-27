#ifndef ROOMDTO_H
#define ROOMDTO_H

#include <QObject>

class RoomDto: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ getId)
    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(int roomTypeId READ getRoomTypeId)
    Q_PROPERTY(bool needClean READ getNeedClean WRITE setNeedClean)
    Q_PROPERTY(bool locked READ getLocked WRITE setLocked)
    Q_PROPERTY(QString description READ getDescription WRITE setDescription)

private:
    int id;
    QString name;
    int roomTypeId;
    bool needClean;
    bool locked;
    QString description;
public:
    explicit RoomDto(QObject *parent = nullptr);
    QString getName() const;
    void setName(const QString &value);
    int getRoomTypeId() const;
    void setRoomTypeId(int value);
    bool getNeedClean() const;
    void setNeedClean(bool value);
    bool getLocked() const;
    void setLocked(bool value);
    QString getDescription() const;
    void setDescription(const QString &value);
    int getId() const;
    void setId(int value);
};

#endif // ROOMDTO_H
