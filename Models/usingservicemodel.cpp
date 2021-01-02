#include "usingservicemodel.h"
#include <QDebug>

int UsingServiceModel::vectorIndex(int x, int y) const
{
    return x + columnCount() * y;
}

UsingServiceModel::UsingServiceModel(QObject *parent) : QAbstractTableModel(parent)
{
    vector.clear();
}

int UsingServiceModel::rowCount(const QModelIndex &) const
{
    return rows;
}

int UsingServiceModel::columnCount(const QModelIndex &) const
{
    return 5;
}

QVariant UsingServiceModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole)
    {
        if (orientation == Qt::Horizontal)
        {
            switch (section) {
            case 0:
                return tr("Số");
            case 1:
                return tr("Mã dịch vụ");
            case 2:
                return tr("Loại dịch vụ");
            case 3:
                return tr("Giá");
            case 4:
                return tr("Nội dung");
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}

QVariant UsingServiceModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case Qt::DisplayRole:
        return vector[vectorIndex(index.column(), index.row())];
    }
    return QVariant();
}

bool UsingServiceModel::addRow(int id, int serviceTypeId, const QString &serviceTypeName, qint64 price, const QString &content)
{
    rows++;
    qDebug() << rowCount();
    qDebug() << columnCount();
    QAbstractItemModel::beginResetModel();
    vector.resize(rowCount() * columnCount());
    vector[vectorIndex(0, rows-1)] = id;
    vector[vectorIndex(1, rows-1)] = serviceTypeId;
    vector[vectorIndex(2, rows-1)] = serviceTypeName;
    vector[vectorIndex(3, rows-1)] = price;
    vector[vectorIndex(4, rows-1)] = content;
    QAbstractItemModel::endResetModel();
    return true;
}

bool UsingServiceModel::removeRow(int row)
{
    QAbstractItemModel::beginResetModel();
    vector.remove(vectorIndex(0, row), 5);
    rows--;
    vector.resize(rowCount() * columnCount());
    QAbstractItemModel::endResetModel();
    return true;
}

bool UsingServiceModel::clear()
{
    QAbstractItemModel::beginResetModel();
    rows = 0;
    vector.clear();
    QAbstractItemModel::endResetModel();
    return true;
}
