#ifndef PLAINTEXTFORMAT_H
#define PLAINTEXTFORMAT_H

#include <QObject>
#include <QQuickTextDocument>
#include "Highlighter.h"


class PlainTextFormat : public QObject
{
    Q_OBJECT

	Q_PROPERTY(
		QQuickTextDocument* textDocument
		READ getTextDocument
		WRITE setTextDocument
		NOTIFY textDocumentChanged
	)

public:
    explicit PlainTextFormat(QObject *parent = 0);
	void setTextDocument(QQuickTextDocument *textDocument);
	QQuickTextDocument* getTextDocument() const;

signals:
    void textDocumentChanged();

private:
    QQuickTextDocument *m_textDocument;
	Highlighter *m_highlighter;
};

#endif