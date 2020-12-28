#include "avatarimageprovider.h"
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlField>

AvatarImageProvider::AvatarImageProvider(): QQuickImageProvider(QQuickImageProvider::Image)
{

}

QImage AvatarImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QSqlQuery _query;
    _query.prepare("SELECT [id],[avatar]"
                   "FROM [dbo].[user_account] WHERE id = ?");
    _query.addBindValue(id.toInt());
    _query.exec();
    _query.next();
    QByteArray bytes = _query.value("avatar").toByteArray();
    QImage image;
    QImage result;
    image.loadFromData(bytes);
    if (requestedSize.isValid()) {
        result = image.scaled(requestedSize, Qt::KeepAspectRatio);
    } else {
        result = image;
    }
    *size = result.size();
    return image;
}
