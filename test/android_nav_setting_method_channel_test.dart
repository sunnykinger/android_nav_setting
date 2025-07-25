import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_nav_setting/android_nav_setting_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAndroidNavSetting platform = MethodChannelAndroidNavSetting();
  const MethodChannel channel = MethodChannel('android_nav_setting');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
          (MethodCall methodCall) async {
        if (methodCall.method == 'getNavigationMode') {
          return 0; // Mock value, e.g., 0 for three-button navigation
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getNavigationMode', () async {
    expect(await platform.getNavigationMode(), 0);
  });
}