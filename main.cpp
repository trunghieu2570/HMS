#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickView>
#include "Models/testmodel.h"
#include <QQmlContext>
#include "Database/hmsdatabase.h"
#include "Models/clientsqlmodel.h"
#include "Models/roomtypesqlmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    auto *db = HMSDatabase::getInstance();
    if (db->open()) {
        qDebug() << "Connect to database successfully";
    }

    auto *clientModel = new ClientSqlModel;
    clientModel->populate();
    auto *roomTypeModel = new RoomTypeSqlModel;
    roomTypeModel->populate();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("myModel", new TestModel);
    engine.rootContext()->setContextProperty("clientModel", clientModel);
    engine.rootContext()->setContextProperty("roomTypeModel", roomTypeModel);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
