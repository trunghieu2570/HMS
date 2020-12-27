#ifndef SERVICETYPEDTO_H
#define SERVICETYPEDTO_H

#include <QObject>

class ServiceTypeDto: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(QString description READ getDescription WRITE setDescription)
    Q_PROPERTY(qint64 basePrice READ getBasePrice WRITE setBasePrice)
private:
    QString name;
    QString description;
    qint64 basePrice;
public:
    explicit ServiceTypeDto(QObject *parent = nullptr);
    QString getName() const;
    void setName(const QString &value);
    qint64 getBasePrice() const;
    void setBasePrice(const qint64 &value);
    QString getDescription() const;
    void setDescription(const QString &value);
};

#endif // SERVICETYPEDTO_H
