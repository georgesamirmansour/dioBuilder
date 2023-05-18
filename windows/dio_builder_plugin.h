#ifndef FLUTTER_PLUGIN_DIO_BUILDER_PLUGIN_H_
#define FLUTTER_PLUGIN_DIO_BUILDER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace dio_builder {

class DioBuilderPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DioBuilderPlugin();

  virtual ~DioBuilderPlugin();

  // Disallow copy and assign.
  DioBuilderPlugin(const DioBuilderPlugin&) = delete;
  DioBuilderPlugin& operator=(const DioBuilderPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace dio_builder

#endif  // FLUTTER_PLUGIN_DIO_BUILDER_PLUGIN_H_
