package com.warnersnotes.warnersos

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import android.net.Uri
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.provider.Settings
import android.view.KeyEvent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val navigationBarChannel = "com.warnersnotes.warnersos/navigationBar"
    private val placeCallChannel = "com.warnersnotes.warnersos/placeCall"
    private val buttonPressChannel = "com.warnersnotes.warnersos/buttonPress"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, navigationBarChannel).setMethodCallHandler {
            call, result ->
                if (call.method == "enableNavBar") {
                    Settings.System.putInt(contentResolver, "navigation_bar_enabled", 1)
                    Settings.System.putInt(contentResolver, "status_bar_enabled", 1)
                } else if (call.method == "disableNavBar") {
                    Settings.System.putInt(contentResolver, "navigation_bar_enabled", 0)
                    Settings.System.putInt(contentResolver, "status_bar_enabled", 0)
                }
                else {
                    result.notImplemented()
                }
        }

        MethodChannel(flutterEngine.dartExecutor, buttonPressChannel).setMethodCallHandler { call, result ->
            if (call.method == "volumeUp") {
                val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_RAISE, AudioManager.FLAG_SHOW_UI)
                result.success(null)
            } else if (call.method == "volumeDown") {
                val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_LOWER, AudioManager.FLAG_SHOW_UI)
                result.success(null)
            } else {
                print(call.method)
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, placeCallChannel).setMethodCallHandler {
            call, result ->
                if (call.method == "placeCall") {
                    val phoneNumber = call.argument<String>("phoneNumber")
                    val intent = Intent(Intent.ACTION_CALL, Uri.parse("tel:" + phoneNumber))
                    startActivity(intent)
                }
                else {
                    result.notImplemented()
                }
        }
    }

    override fun dispatchKeyEvent(event: KeyEvent?): Boolean {
        flutterEngine?.let {
            if  (event?.action == KeyEvent.ACTION_DOWN) {
                MethodChannel(it.dartExecutor.binaryMessenger, buttonPressChannel).invokeMethod(event.keyCode.toString(), event.keyCode)
                return true
            }
            print(event?.keyCode)
        }
        return super.dispatchKeyEvent(event)
    }
}