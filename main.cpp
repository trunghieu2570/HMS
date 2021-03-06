#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickView>
#include <QQmlContext>
#include <QFont>
#include "Database/hmsdatabase.h"
//Model
#include "Models/clientsqlmodel.h"
#include "Models/roomtypesqlmodel.h"
#include "Models/inventorysqlmodel.h"
#include "Models/roominventorysqlmodel.h"
#include "Models/roomsqlmodel.h"
#include "Models/servicetypesqlmodel.h"
#include "Models/useraccountsqlmodel.h"
#include "Models/roomcalendartablemodel.h"
#include "Models/usingservicemodel.h"
#include "Models/reservationsqlmodel.h"
#include "Models/servicesqlmodel.h"
//Dto
#include "Dto/roomtypedto.h"
#include "Dto/inventorydto.h"
#include "Dto/clientdto.h"
#include "Dto/roomdto.h"
#include "Dto/servicetypedto.h"
#include "Dto/useraccountdto.h"
#include "Dto/reservationdto.h"
//Provider
#include "Providers/avatarimageprovider.h"

//Service
#include "Services/authenticationservice.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QFont fon("Arial", 9);
    app.setFont(fon);

    auto *db = HMSDatabase::getInstance();
    if (db->open()) {
        qDebug() << "Connect to database successfully";
    }

    auto *clientModel = new ClientSqlModel;
    clientModel->populate();
    auto *roomTypeModel = new RoomTypeSqlModel;
    roomTypeModel->populate();
    auto *inventoryModel = new InventorySqlModel;
    inventoryModel->populate();
    auto *roomModel = new RoomSqlModel;
    roomModel->populate();
    auto *roomInventoryModel = new RoomInventorySqlModel;
    auto *serviceTypeModel = new ServiceTypeSqlModel;
    serviceTypeModel->populate();
    auto *userAccountModel = new UserAccountSqlModel;
    userAccountModel->populate();
    auto *roomCalendarModel = new RoomCalendarTableModel;
    roomCalendarModel->populate(1,2021);
    auto usingServiceModel = new UsingServiceModel;
    usingServiceModel->clear();
    auto serviceModel = new ServiceSqlModel;
    serviceModel->populate();


    AuthenticationService *authService = AuthenticationService::getInstance();


    auto *avatarProvider = new AvatarImageProvider;

    QQmlApplicationEngine engine;

    qmlRegisterType<RoomTypeDto>("hms.dto", 1, 0, "RoomTypeDto");
    qmlRegisterType<InventoryDto>("hms.dto", 1, 0, "InventoryDto");
    qmlRegisterType<ClientDto>("hms.dto", 1, 0, "ClientDto");
    qmlRegisterType<RoomDto>("hms.dto", 1, 0, "RoomDto");
    qmlRegisterType<ServiceTypeDto>("hms.dto", 1, 0, "ServiceTypeDto");
    qmlRegisterType<UserAccountDto>("hms.dto", 1, 0, "UserAccountDto");
    qmlRegisterType<ReservationDto>("hms.dto", 1, 0, "ReservationDto");

    engine.addImageProvider("avatar", avatarProvider);
    engine.rootContext()->setContextProperty("clientModel", clientModel);
    engine.rootContext()->setContextProperty("roomTypeModel", roomTypeModel);
    engine.rootContext()->setContextProperty("inventoryModel", inventoryModel);
    engine.rootContext()->setContextProperty("roomModel", roomModel);
    engine.rootContext()->setContextProperty("roomInventoryModel", roomInventoryModel);
    engine.rootContext()->setContextProperty("serviceTypeModel", serviceTypeModel);
    engine.rootContext()->setContextProperty("userAccountModel", userAccountModel);
    engine.rootContext()->setContextProperty("authenticationService", authService);
    engine.rootContext()->setContextProperty("roomCalendarModel", roomCalendarModel);
    engine.rootContext()->setContextProperty("usingServiceModel", usingServiceModel);
    engine.rootContext()->setContextProperty("serviceModel", serviceModel);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    //const QUrl url(QStringLiteral("qrc:/dialogs/UseServiceDialog.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
