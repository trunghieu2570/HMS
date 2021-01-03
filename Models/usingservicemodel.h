#ifndef USINGSERVICEMODEL_H
#define USINGSERVICEMODEL_H

#include <QAbstractTableModel>

class UsingServiceModel: public QAbstractTableModel
{
    Q_OBJECT
private:
    QVector<QVariant> vector;
    int rows = 0;
    int vectorIndex(int x, int y) const;
public:
    explicit UsingServiceModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    int columnCount(const QModelIndex & = QModelIndex()) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override ;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE bool addRow(int id, int serviceTypeId, const QString &serviceTypeName, qint64 price, const QString &content);
    Q_INVOKABLE bool removeRow(int row);
    Q_INVOKABLE bool clear();
    Q_INVOKABLE bool saveToDb(int resId);
    Q_INVOKABLE bool loadFromDb(int resId);
    QHash<int, QByteArray> roleNames() const override
    {
        return { {Qt::DisplayRole, "display"} };
    }
};

#endif // USINGSERVICEMODEL_H
