#include "fileManager.h"

FileManager::FileManager(QObject *parent) :
	QObject(parent)//,
	//m_process(new QProcess(this))
{
}

QString FileManager::read(const QString &filename)
{
	QFile file(filename);
	if(!file.open(QIODevice::ReadOnly)) {
		QMessageBox::information(0, "error", file.errorString());
	}

	QTextStream in(&file);

	//while(!in.atEnd()) {
	QString content = in.readAll();
	//}

	file.close();
	return content;
}

void FileManager::write(const QString &filename, const QString &filecontent)
{
	QFile file(filename);
	if(file.open(QIODevice::WriteOnly | QIODevice::Text)) {
		QTextStream out(&file);
		out << filecontent;
	}
	file.close();
}

QString FileManager::getProva()
{
	QString cmd = "ciao a tutti quanti";

	return cmd;
}