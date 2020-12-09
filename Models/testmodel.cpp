#include "testmodel.h"


int TestModel::rowCount(const QModelIndex &) const
{
    return 10;
}

int TestModel::columnCount(const QModelIndex &) const
{
    return 10;
}

QVariant TestModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case Qt::DisplayRole:
        return QString("%1, %2").arg(index.column()).arg(index.row());
    default:
        break;
    }

    return QVariant();
}

QHash<int, QByteArray> TestModel::roleNames() const
{
    return { {Qt::DisplayRole, "display"} };
}

QVariant TestModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(role == Qt::DisplayRole) {
        if (orientation == Qt::Orientation::Horizontal) {
            switch (section) {
            case 0:
                return "Hello";
            case 1:
                return "World";
            default:
                return QVariant();
            }
        }
    }
    return QVariant();
}
