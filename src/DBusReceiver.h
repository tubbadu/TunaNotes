#ifndef DBUSRECEIVER_H
#define DBUSRECEIVER_H

#include <QObject>
#include <QDBusMessage>
#include <QDBusConnection>
#include <QDBusInterface>

class DBusReceiver : public QObject
{
    Q_OBJECT
public:
    explicit DBusReceiver(QObject *parent = nullptr);
	void onHelloSignal();
    Q_INVOKABLE QString getProva();

signals:
    void helloSignalv2();



private:
    //QProcess *m_process;
};

#endif