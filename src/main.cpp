#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <KLocalizedContext>
#include <KLocalizedString>
#include <QFontDatabase>
#include <QLocalServer>
#include <QDBusMessage>
#include <QDBusConnection>

#include "launcher.h"
#include "fileManager.h"
#include "plainTextFormat.h"
#include "DBusReceiver.h"


void emitSignal(QString dbusName)
{
	qWarning() << "sending helloSignal to:" << dbusName;
	QDBusConnection connection = QDBusConnection::sessionBus();
	QDBusMessage message = QDBusMessage::createSignal("/", dbusName, "helloSignal");
	connection.send(message);
}


int main(int argc, char *argv[])
{
	QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QApplication app(argc, argv);
	KLocalizedString::setApplicationDomain("tunanotes");
	QCoreApplication::setOrganizationName(QStringLiteral("KDE"));
	QCoreApplication::setOrganizationDomain(QStringLiteral("kde.org"));
	QCoreApplication::setApplicationName(QStringLiteral("tunanotes"));
	QQmlApplicationEngine engine;

	qmlRegisterType<Launcher>("Launcher", 1, 0, "Launcher");
	qmlRegisterType<FileManager>("FileManager", 1, 0, "FileManager");
	qmlRegisterType<PlainTextFormat>("PlainTextFormat", 1, 0, "PlainTextFormat");
	qmlRegisterType<DBusReceiver>("DBusReceiver", 1, 0, "DBusReceiver");

	const QFont fixedFont = QFontDatabase::systemFont(QFontDatabase::FixedFont);
	engine.rootContext()->setContextProperty("fixedFont", fixedFont);

	engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

	if (engine.rootObjects().isEmpty()) {
		return -1;
	}


	QLocalServer server;
	bool serverRunning = !server.listen(QCoreApplication::applicationName());
	QString dbusName = QCoreApplication::organizationDomain() + "." + QCoreApplication::applicationName();


	return app.exec();


	// may cause errors!
	if(!serverRunning){
		qWarning() << "Server not running";
		
		return app.exec();
	} else {
		qWarning() << "Server already running";
		emitSignal("kde.org.tunanotes");
		return 0;
	}
}
