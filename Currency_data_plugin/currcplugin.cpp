#include "currcplugin.h"

#include "currencyfiltermodel.h"
#include "settings.h"
#include "EnumProvider.h"
#include <qqml.h>

#define DEFAULT_REGISTER_SINGLETON(tname) \
    qmlRegisterSingletonType<tname>(uri, 1, 0, #tname, singleton_provider<tname>)

QObject *filtermodel_Singleton_Provider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    CurrencyFilterModel *obj  = new CurrencyFilterModel;
    return obj;
}

void ChartsPlugin::registerTypes(const char *uri)
{
   // @uri CurrcData
    qmlRegisterType<CurrencyFilterModel>(uri, 1, 0, "CurrencyFilterModel");
//    qmlRegisterSingletonType<Settings>(uri, 1, 0, "Settings", singleton_provider<Settings>);
//    qmlRegisterSingletonType<CurrencyFilterModel>("CurrcData", 1, 0, "CurrencyFilterModel", filtermodel_Singleton_Provider);
//    DEFAULT_REGISTER_SINGLETON(CurrencyFilterModel);
    DEFAULT_REGISTER_SINGLETON(Settings);
    DEFAULT_REGISTER_SINGLETON(EnumProvider);
}
