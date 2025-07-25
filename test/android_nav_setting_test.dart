import 'package:flutter_test/flutter_test.dart';
import 'package:android_nav_setting/android_nav_setting.dart';
import 'package:android_nav_setting/android_nav_setting_platform_interface.dart';
import 'package:android_nav_setting/android_nav_setting_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAndroidNavSettingPlatform
    with MockPlatformInterfaceMixin
    implements AndroidNavSettingPlatform {

  @override
  Future<int?> getNavigationMode() => Future.value(0); // Mock value, e.g., 0 for three-button navigation
}

void main() {
  final AndroidNavSettingPlatform initialPlatform = AndroidNavSettingPlatform.instance;

  test('$MethodChannelAndroidNavSetting is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidNavSetting>());
  });

  test('getNavigationMode', () async {
    AndroidNavSetting androidNavSettingPlugin = AndroidNavSetting();
    MockAndroidNavSettingPlatform fakePlatform = MockAndroidNavSettingPlatform();
    AndroidNavSettingPlatform.instance = fakePlatform;

    expect(await androidNavSettingPlugin.getNavigationMode(), 0);
  });
}