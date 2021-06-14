package com.example.flutter_trip

import com.example.plugin.MethodChannelPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannelPlugin.register(this,flutterEngine.dartExecutor.binaryMessenger)
    }
}
