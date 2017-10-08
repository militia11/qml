TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cc

RESOURCES += qml.qrc
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
#/home/mmichniewski/Qt5.9.1/5.9.1/gcc_64/qml
#/home/mmichniewski/Qt5.9.1/5.9.1/Src/
#QML2_IMPORT_PATH = /home/mmichniewski/Qt5.9.1/5.9.1/gcc_64/qml
#/home/mmichniewski/Qt5.9.1/5.9.1/Src/qtdeclarative/src/imports/qtquick2
#/home/mmichniewski/Qt5.9.1/5.9.1/Src/qtquickcontrols2/include/QtQuickControls2/5.9.1/QtQuickControls2
# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

HEADERS += \
    Shapes.h \
    CanvasModes.h

