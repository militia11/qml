#ifndef CANVASMODES_H
#define CANVASMODES_H

#include <QObject>

class CanvasModes : public QObject {
		Q_OBJECT
	public:
		enum class Mode {
			NONE,
			DRAWING,
			ADDSHAPES,
			RUBBER
		};
		Q_ENUMS(Mode)
};

#endif // CANVASMODES_H
