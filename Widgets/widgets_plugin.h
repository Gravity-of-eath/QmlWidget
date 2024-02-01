#ifndef WIDGETS_PLUGIN_H
#define WIDGETS_PLUGIN_H

#include <QQmlExtensionPlugin>

class WidgetsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override;
};

#endif // WIDGETS_PLUGIN_H
