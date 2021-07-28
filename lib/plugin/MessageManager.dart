import 'package:flutter/services.dart';

class MessageManager {
  static const MethodChannel _channel = const MethodChannel('MethodChannelPlugin');

  static Future<String> start({Map params}) async {
    return await _channel.invokeMethod('start', params ?? {});
  }


  //打开一个Activity
  static Future<String> openNewNativePage(params) async {
    return await _channel.invokeMethod('openActivity',params ?? null);
  }

  static Future<String> cancel() async {
    return await _channel.invokeMethod('cancel');
  }
}