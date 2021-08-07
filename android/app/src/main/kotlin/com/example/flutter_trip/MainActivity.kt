package com.example.flutter_trip

import android.os.Bundle
import android.os.PersistableBundle
import com.example.plugin.MethodChannelPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import org.devio.flutter.splashscreen.SplashScreen

class MainActivity: FlutterActivity() {




    override fun onCreate(savedInstanceState: Bundle?) {
        SplashScreen.show(this,true)
        super.onCreate(savedInstanceState)
    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannelPlugin.register(this,flutterEngine.dartExecutor.binaryMessenger)
    }
}
