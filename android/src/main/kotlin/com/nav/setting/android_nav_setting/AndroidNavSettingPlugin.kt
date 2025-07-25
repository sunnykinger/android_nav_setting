package com.nav.setting.android_nav_setting

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AndroidNavSettingPlugin */
class AndroidNavSettingPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_nav_setting")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "isThreeButtonNavigationEnabled" -> {
                result.success(isThreeButtonNavigation())
            }

            "isGestureNavigationEnabled" -> {
                result.success(isGestureNavigation())
            }

            "getNavigationMode" -> {
                result.success(getNavigationMode())
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getNavigationMode(): Int {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                Settings.Secure.getInt(context.contentResolver, "navigation_mode", 0)
            } else {
                // Pre-Android 10: Assume 3-button navigation
                0
            }
        } catch (e: Settings.SettingNotFoundException) {
            Log.e(TAG, "Error reading navigation mode", e)
            0 // Fallback
        }
    }

    private fun isThreeButtonNavigation(): Boolean {
        return getNavigationMode() == 0
    }

    private fun isGestureNavigation(): Boolean {
        return getNavigationMode() == 2
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
