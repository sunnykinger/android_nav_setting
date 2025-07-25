import 'dart:io';

import 'android_nav_setting_platform_interface.dart';

class AndroidNavSetting {
  Future<int> getNavigationMode() async {
    if (Platform.isAndroid) {
      try {
        return await AndroidNavSettingPlatform.instance.getNavigationMode() ??
            0;
      } catch (e) {
        return 0; // Fallback for errors on Android
      }
    } else if (Platform.isIOS) {
      return 2; // Assume gesture navigation on iOS
    } else {
      return 0; // Fallback for other platforms
    }
  }

  Future<bool> isThreeButtonNavigationEnabled() async {
    final int mode = await getNavigationMode();
    return mode == 0 || mode == 1; // Treat 2-button as buttons (rare)
  }

  Future<bool> isGestureNavigationEnabled() async {
    final int mode = await getNavigationMode();
    return mode == 2;
  }
}
