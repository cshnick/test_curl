#include "currcplugin.h"

#include "currencyfiltermodel.h"
#include "settings.h"
#include "EnumProvider.h"
#ifndef PLASMA_WIDGET
#include <qqml.h>
#define DEFAULT_REGISTER_SINGLETON(tname) \
    qmlRegisterSingletonType<tname>(uri, 1, 0, #tname, singleton_provider<tname>)
#else // PLASMA_WIDGET
#include <qdeclarative.h>
#endif // PLASMA_WIDGET

QObject *filtermodel_Singleton_Provider(BASE_ENGINE *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    CurrencyFilterModel *obj  = new CurrencyFilterModel;
    return obj;
}

void ChartsPlugin::registerTypes(const char *uri)
{

   // @uri CurrcData
    qmlRegisterType<EnumProvider>(uri, 1, 0, "EnumProvider");
    qmlRegisterType<CurrencyFilterModel>(uri, 1, 0, "CurrencyFilterModel");
    qmlRegisterType<Settings>(uri, 1, 0, "Settings");
//    qmlRegisterSingletonType<Settings>(uri, 1, 0, "Settings", singleton_provider<Settings>);
//    qmlRegisterSingletonType<CurrencyFilterModel>("CurrcData", 1, 0, "CurrencyFilterModel", filtermodel_Singleton_Provider);
//    DEFAULT_REGISTER_SINGLETON(CurrencyFilterModel);
//    DEFAULT_REGISTER_SINGLETON(Settings);
//    DEFAULT_REGISTER_SINGLETON(EnumProvider);
}

#ifdef PLASMA_WIDGET
Q_EXPORT_PLUGIN2(currcdataplugin, ChartsPlugin)
#endif //PLASMA_WIDGET
