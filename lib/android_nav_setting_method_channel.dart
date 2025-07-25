import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'android_nav_setting_platform_interface.dart';

/// An implementation of [AndroidNavSettingPlatform] that uses method channels.
class MethodChannelAndroidNavSetting extends AndroidNavSettingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('android_nav_setting');

  @override
  Future<int?> getNavigationMode() async {
    final int? mode = await methodChannel.invokeMethod<int>('getNavigationMode');
    return mode;
  }
}
