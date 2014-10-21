#define DECLARE_VISIBLE __attribute__((__visibility__("default")))

#include <QtCore/qglobal.h>

#if defined(URLLOADER_LIBRARY)
#  define URLLOADER_EXPORT Q_DECL_EXPORT
#else
#  define URLLOADER_EXPORT Q_DECL_IMPORT
#endif

