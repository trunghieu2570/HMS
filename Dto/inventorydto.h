#ifndef INVENTORYDTO_H
#define INVENTORYDTO_H

#include <QObject>

class InventoryDto: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName)

private:
    QString name;
public:
    explicit InventoryDto(QObject *parent = nullptr);
    QString getName() const;
    void setName(const QString &value);
};

#endif // INVENTORYDTO_H
