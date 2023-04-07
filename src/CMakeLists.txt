add_executable(tunanotes
	main.cpp
	resources.qrc
	launcher.cpp
	fileManager.cpp
	plainTextFormat.cpp
	Highlighter.cpp
)

find_package(KF5SyntaxHighlighting)
find_package(KF5ConfigWidgets)


target_link_libraries(tunanotes
	Qt5::Quick
	Qt5::Qml
	Qt5::Gui
	Qt5::QuickControls2
	Qt5::Widgets
	KF5::Kirigami2
	KF5::I18n
	KF5::SyntaxHighlighting
	KF5::ConfigWidgets
) 
