package com.example.plugin

import android.app.Activity
import android.content.Intent
import android.widget.Toast
import com.example.flutter_trip.SecondActivity

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MethodChannelPlugin : MethodChannel.MethodCallHandler {

    private var activity: Activity? = null

    constructor(activity: Activity?) {
        this.activity = activity
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "showMessage" -> {

            }

            "openActivity" -> {
                var message: String? = call.argument("message")
                Toast.makeText(this.activity,message,Toast.LENGTH_LONG).show()
                this.activity?.startActivity(Intent(this.activity,SecondActivity::class.java))
            }
        }
    }

    companion object {
        fun register(activity: Activity, message: BinaryMessenger) {
            var channel = MethodChannel(message, "MethodChannelPlugin")
            var instance = MethodChannelPlugin(activity)
            channel.setMethodCallHandler(instance)
        }
    }
}