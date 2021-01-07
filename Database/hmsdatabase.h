#ifndef HMSDATABASE_H
#define HMSDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QHostInfo>

class HMSDatabase
{
private:
    static HMSDatabase *_instance;
    QSqlDatabase db;
    const bool windowsAuth = false;
    const QString hostname = QHostInfo::localHostName();
    const QString sqlInstance = "SQLEXPRESS";
    const QString username = "SA";
    const QString password = "##123qwe";
    const QString dbname = "HOTEL_DATABASE";
public:
    HMSDatabase();
    static HMSDatabase *getInstance();
    bool open();
    void close();
    ~HMSDatabase();
};

#endif // HMSDATABASE_H
