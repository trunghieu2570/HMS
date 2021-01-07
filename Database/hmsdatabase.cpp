#include "hmsdatabase.h"

HMSDatabase *HMSDatabase::_instance = nullptr;

HMSDatabase::HMSDatabase()
{
    db = QSqlDatabase::addDatabase("QODBC3");
    QString connectString = "Driver={SQL Server Native Client 11.0};";                     // Driver is now {SQL Server Native Client 11.0}
    connectString.append(QString("Server=lpc:%1\\%2;").arg(this->hostname, this->sqlInstance));// Hostname,SQL-Server Instance
    connectString.append(QString("Database=%1;").arg(this->dbname));  // Schema
    if(!windowsAuth) {
        connectString.append(QString("Uid=%1;").arg(this->username));// User
        connectString.append(QString("Pwd=%1;").arg(this->password));// Pass
    } else {
        connectString.append(QString("Trusted_Connection=yes;"));
    }
    db.setDatabaseName(connectString);
}

HMSDatabase *HMSDatabase::getInstance()
{
    if(_instance == nullptr) {
        _instance = new HMSDatabase();
    }
    return _instance;
}

bool HMSDatabase::open()
{
    if(db.isOpen())
        return true;
    else
        return db.open();
}

void HMSDatabase::close()
{
    return db.close();
}

HMSDatabase::~HMSDatabase()
{
    db.close();
}
