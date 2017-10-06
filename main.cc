#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include "Shapes.h"
#include "CanvasModes.h"

int main(int argc, char *argv[]) {
	QGuiApplication app(argc, argv);

	qRegisterMetaType<Shapes::Shape>("Shapes::Shape");
	qmlRegisterType<Shapes>("ShapesTypes", 1, 0, "Shapes");

	qRegisterMetaType<CanvasModes::Mode>("CanvasModes::Mode");
	qmlRegisterType<CanvasModes>("CanvasModes", 1, 0, "CanvasModes");

	QQmlApplicationEngine engine;
	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

	return app.exec();
}
