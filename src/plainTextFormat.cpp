#include "plainTextFormat.h"

PlainTextFormat::PlainTextFormat(QObject *parent) :
	QObject(parent), m_textDocument(nullptr)
{
}


QQuickTextDocument* PlainTextFormat::getTextDocument() const
{
	return m_textDocument;
}

void PlainTextFormat::setTextDocument(QQuickTextDocument *textDocument)
{
	if (m_textDocument != textDocument) {
        m_textDocument = textDocument;
        emit textDocumentChanged();
		m_highlighter = new Highlighter(textDocument->textDocument());
    }
}