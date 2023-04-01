#include "launcher.h"


#include <KSyntaxHighlighting/Definition>
#include <KSyntaxHighlighting/Repository>
#include <KSyntaxHighlighting/SyntaxHighlighter>
#include <KSyntaxHighlighting/Theme>


Launcher::Launcher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
}

QString Launcher::launch(const QString &program)
{
    m_process->start(program);
    m_process->waitForFinished(-1);
    QByteArray bytes = m_process->readAllStandardOutput();
    QString output = QString::fromLocal8Bit(bytes);
    return output;
}

QVector<KSyntaxHighlighting::Definition> Launcher::getProva()
{
	static KSyntaxHighlighting::Repository *m_repository;
	m_repository = new KSyntaxHighlighting::Repository();
    //QString cmd = "ciao a tutti quanti";

    return m_repository->definitions();
}