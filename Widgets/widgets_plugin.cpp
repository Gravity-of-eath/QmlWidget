#include "widgets_plugin.h"

#include <qqml.h>
#include <qarraylist.h>
#include <qmlarraylist.h>

void WidgetsPlugin::registerTypes(const char *uri)
{
    // @uri com.mycompany.qmlcomponents
    qmlRegisterType(QUrl("qrc:/SwicthButton.qml"),uri, 1, 0, "SwicthButton");
    qmlRegisterType(QUrl("qrc:/Dashboard2D.qml"),uri, 1, 0, "Dashboard2D");
    qmlRegisterType(QUrl("qrc:/ArrayList.qml"),uri, 1, 0, "ArrayList");
    qmlRegisterType<QArrayList>("wid", 1, 0, "QArrayList");
    qmlRegisterType<QmlArrayList>("wid", 1, 0, "QmlArrayList");
}

