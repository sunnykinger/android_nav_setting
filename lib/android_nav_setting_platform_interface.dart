import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android_nav_setting_method_channel.dart';

abstract class AndroidNavSettingPlatform extends PlatformInterface {
  /// Constructs a AndroidNavSettingPlatform.
  AndroidNavSettingPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidNavSettingPlatform _instance = MethodChannelAndroidNavSetting();

  /// The default instance of [AndroidNavSettingPlatform] to use.
  ///
  /// Defaults to [MethodChannelAndroidNavSetting].
  static AndroidNavSettingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AndroidNavSettingPlatform] when
  /// they register themselves.
  static set instance(AndroidNavSettingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int?> getNavigationMode() {
    throw UnimplementedError('getNavigationMode() has not been implemented.');
  }
}