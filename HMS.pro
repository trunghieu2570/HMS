QT += quick quickcontrols2 sql

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        Database/hmsdatabase.cpp \
        Dto/clientdto.cpp \
        Dto/inventorydto.cpp \
        Dto/roomtypedto.cpp \
        Models/clientsqlmodel.cpp \
        Models/inventorysqlmodel.cpp \
        Models/roomtypesqlmodel.cpp \
        Models/testmodel.cpp \
        main.cpp

RESOURCES += qml.qrc \
    icons.qrc

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
    Dto/roomtypedto.h \
    Models/clientsqlmodel.h \
    Models/inventorysqlmodel.h \
    Models/roomtypesqlmodel.h \
    Models/testmodel.h
