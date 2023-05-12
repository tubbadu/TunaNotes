#include "DBusReceiver.h"
#include <QDebug>


DBusReceiver::DBusReceiver(QObject *parent) :
	QObject(parent)
{
	QDBusConnection sessionBus = QDBusConnection::sessionBus();
	
	if (sessionBus.isConnected()) {
		QString service = "kde.org.tunanotes";
		QString path = "/";
		QString interface = "kde.org.tunanotes";
		QString signal = "helloSignal";

		//QString match = QString("type='signal',interface='%1',member='%2'").arg(interface, signal);
		sessionBus.connect(service, path, interface, signal, this, SLOT(onHelloSignal()));
		qWarning() << "done";
	} else {
		qWarning() << "not working";
	}
}

void DBusReceiver::onHelloSignal()
{
	qWarning() << "cazzopalle";
    //emit helloSignalv2();
}


QString DBusReceiver::getProva()
{
	QString cmd = "ciao a tutti quanti";

	return cmd;
}