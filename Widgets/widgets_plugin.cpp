#include "widgets_plugin.h"

#include <qqml.h>
#include <qarraylist.h>
#include <qmlarraylist.h>

void WidgetsPlugin::registerTypes(const char *uri)
{
    // @uri com.mycompany.qmlcomponents
    qmlRegisterType<QArrayList>("QArrayList", 1, 0, "QArrayList");
    qmlRegisterType<QmlArrayList>("QArrayList", 1, 0, "QmlArrayList");
    qmlRegisterType(QUrl("qrc:/SwicthButton.qml"),uri, 1, 0, "SwicthButton");
    qmlRegisterType(QUrl("qrc:/Dashboard2D.qml"),uri, 1, 0, "Dashboard2D");
    qmlRegisterType(QUrl("qrc:/ArrayList.qml"),uri, 1, 0, "ArrayList");
    qmlRegisterType(QUrl("qrc:/FragmentManager.qml"),uri, 1, 0, "FragmentManager");
    qmlRegisterType(QUrl("qrc:/LinearLayout.qml"),uri, 1, 0, "LinearLayout");
    qmlRegisterType(QUrl("qrc:/AbsFragment.qml"),uri, 1, 0, "AbsFragment");
}

