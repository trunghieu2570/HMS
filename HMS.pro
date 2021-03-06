QT += quick quickcontrols2 sql

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

include (SortFilterProxyModel/SortFilterProxyModel.pri)

SOURCES += \
        Database/hmsdatabase.cpp \
        Dto/clientdto.cpp \
        Dto/inventorydto.cpp \
        Dto/reservationdto.cpp \
        Dto/roomdto.cpp \
        Dto/roomtypedto.cpp \
        Dto/servicetypedto.cpp \
        Dto/useraccountdto.cpp \
        Models/clientsqlmodel.cpp \
        Models/inventorysqlmodel.cpp \
        Models/reservationsqlmodel.cpp \
        Models/roomcalendartablemodel.cpp \
        Models/roominventorysqlmodel.cpp \
        Models/roomsqlmodel.cpp \
        Models/roomtypesqlmodel.cpp \
        Models/servicesqlmodel.cpp \
        Models/servicetypesqlmodel.cpp \
        Models/sqlquerymodel.cpp \
        Models/useraccountsqlmodel.cpp \
        Models/usingservicemodel.cpp \
        Providers/avatarimageprovider.cpp \
        Services/authenticationservice.cpp \
        main.cpp

RESOURCES += qml.qrc \
    icons.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Database/hmsdatabase.h \
    Dto/clientdto.h \
    Dto/inventorydto.h \
    Dto/reservationdto.h \
    Dto/roomdto.h \
    Dto/roomtypedto.h \
    Dto/servicetypedto.h \
    Dto/useraccountdto.h \
    Models/clientsqlmodel.h \
    Models/inventorysqlmodel.h \
    Models/reservationsqlmodel.h \
    Models/roomcalendartablemodel.h \
    Models/roominventorysqlmodel.h \
    Models/roomsqlmodel.h \
    Models/roomtypesqlmodel.h \
    Models/servicesqlmodel.h \
    Models/servicetypesqlmodel.h \
    Models/sqlquerymodel.h \
    Models/useraccountsqlmodel.h \
    Models/usingservicemodel.h \
    Providers/avatarimageprovider.h \
    Services/authenticationservice.h
