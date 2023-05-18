#include "include/dio_builder/dio_builder_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dio_builder_plugin.h"

void DioBuilderPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dio_builder::DioBuilderPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
