#ifndef SHAPES_H
#define SHAPES_H

#include <QObject>

class Shapes : public QObject {
		Q_OBJECT
	public:
		enum class Shape {
			RECTANGLE,
			ELISPE
		};
		Q_ENUMS(Shape)
};


#endif // SHAPES_H
