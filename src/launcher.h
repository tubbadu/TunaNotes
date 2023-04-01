#ifndef LAUNCHER_H
#define LAUNCHER_H

#include <QObject>
#include <QProcess>
#include <KSyntaxHighlighting/Definition>
#include <KSyntaxHighlighting/Repository>
#include <KSyntaxHighlighting/SyntaxHighlighter>
#include <KSyntaxHighlighting/Theme>

class Launcher : public QObject
{
    Q_OBJECT
public:
    explicit Launcher(QObject *parent = 0);
    Q_INVOKABLE QString launch(const QString &program);
    Q_INVOKABLE QVector<KSyntaxHighlighting::Definition> getProva();



private:
    QProcess *m_process;
};

#endif