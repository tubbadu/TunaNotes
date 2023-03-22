#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QMessageBox>

class FileManager : public QObject
{
    Q_OBJECT
public:
    explicit FileManager(QObject *parent = 0);
    Q_INVOKABLE QString read(const QString &filename);
    Q_INVOKABLE QString getProva();



private:
    //QProcess *m_process;
};

#endif