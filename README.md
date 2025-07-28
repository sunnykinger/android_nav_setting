# android_nav_setting

A Flutter plugin to detect the system navigation mode on Android devices, supporting identification of three-button navigation, two-button navigation, or gesture navigation. On iOS, it defaults to assuming gesture navigation is enabled.

## Features

- Retrieve the system navigation mode on Android devices using `Settings.Secure.NAVIGATION_MODE`.
- Methods to check if three-button navigation or gesture navigation is enabled.
- Cross-platform compatibility with a fallback for iOS (assumes gesture navigation).
- Lightweight and reliable across all Android OEMs (Samsung, Xiaomi, Huawei, etc.).

## Getting Started

To use this plugin in your Flutter project, add it to your `pubspec.yaml`:

```yaml
dependencies:
  android_nav_setting: ^0.0.2+1
```

Then, run `flutter pub get` to install the plugin.

### Usage

1. Import the plugin:
   ```dart
   import 'package:android_nav_setting/android_nav_setting.dart';
   ```

2. Create an instance of `AndroidNavSetting`:
   ```dart
   final navSetting = AndroidNavSetting();
   ```

3. Check navigation mode or specific navigation types:
   ```dart
   // Get raw navigation mode (0: three-button, 1: two-button, 2: gesture)
   int mode = await navSetting.getNavigationMode();
   print('Navigation Mode: $mode');

   // Check if three-button navigation is enabled
   bool isThreeButton = await navSetting.isThreeButtonNavigationEnabled();
   print('Three-Button Navigation: $isThreeButton');

   // Check if gesture navigation is enabled
   bool isGesture = await navSetting.isGestureNavigationEnabled();
   print('Gesture Navigation: $isGesture');
   ```

### Platform Support

- **Android**: Fully supported. Uses `Settings.Secure.NAVIGATION_MODE` to determine the navigation mode, compatible with Android 10+ (API 29) and falls back to three-button navigation for older versions.
- **iOS**: Returns gesture navigation (`mode 2`) as a default, as modern iOS devices use gesture-based navigation.

### Example

The `example` directory contains a sample Flutter app demonstrating how to use this plugin to display the current navigation mode.

```dart
import 'package:flutter/material.dart';
import 'package:android_nav_setting/android_nav_setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _navigationStatus = 'Unknown';
  final _androidNavSettingPlugin = AndroidNavSetting();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool? isGestureEnabled;
    try {
      isGestureEnabled = await _androidNavSettingPlugin.isGestureNavigationEnabled();
      _navigationStatus = isGestureEnabled ? 'Enabled' : 'Disabled';
    } catch (e) {
      _navigationStatus = 'Failed to get navigation status.';
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Gesture Navigation: $_navigationStatus\n'),
        ),
      ),
    );
  }
}
```

## Installation

1. Add the plugin to your `pubspec.yaml` as shown above.
2. Ensure your Android project's `minSdkVersion` is at least 21 (recommended for broad compatibility).
3. Run `flutter pub get` and use the plugin as shown in the example.

## Testing

The plugin includes unit tests in the `test` directory to verify the platform channel and mock behavior. To run tests:

```bash
flutter test
```

## Notes

- **Android Compatibility**: Tested to work across all major Android OEMs (Samsung, Google, Xiaomi, etc.) using the standard AOSP `navigation_mode` setting.
- **iOS Fallback**: Since iOS does not support customizable navigation modes like Android, the plugin assumes gesture navigation (`mode 2`) for iOS devices.
- **Error Handling**: The plugin gracefully handles errors (e.g., `MissingPluginException` or `Settings.SettingNotFoundException`) with appropriate fallbacks.

For more details on Flutter plugin development, see the [Flutter documentation](https://docs.flutter.dev/development/packages-and-plugins/developing-packages).