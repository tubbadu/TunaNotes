#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <KLocalizedContext>
#include <KLocalizedString>
#include <QFontDatabase>
#include <QLocalServer>

#include "launcher.h"
#include "fileManager.h"
#include "plainTextFormat.h"

int main(int argc, char *argv[])
{
	QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QApplication app(argc, argv);
	KLocalizedString::setApplicationDomain("tunanotes");
	QCoreApplication::setOrganizationName(QStringLiteral("KDE"));
	QCoreApplication::setOrganizationDomain(QStringLiteral("kde.org"));
	QCoreApplication::setApplicationName(QStringLiteral("TunaNotes"));
	QQmlApplicationEngine engine;

	qmlRegisterType<Launcher>("Launcher", 1, 0, "Launcher");
	qmlRegisterType<FileManager>("FileManager", 1, 0, "FileManager");
	qmlRegisterType<PlainTextFormat>("PlainTextFormat", 1, 0, "PlainTextFormat");

	const QFont fixedFont = QFontDatabase::systemFont(QFontDatabase::FixedFont);
	engine.rootContext()->setContextProperty("fixedFont", fixedFont);

	engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

	if (engine.rootObjects().isEmpty()) {
		return -1;
	}


	QLocalServer server;
	bool serverRunning = !server.listen(QCoreApplication::applicationName());
	if(!serverRunning){
		qWarning() << "Server not running";
		
		return app.exec();
	} else {
		qWarning() << "Server already running";
		return 0;
	}
}
