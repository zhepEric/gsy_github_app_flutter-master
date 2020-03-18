
import 'package:flutter/services.dart';

class LogUtil {
  static const perform = const MethodChannel("android_log");

  static void i(String tag, String message){
    perform.invokeMethod('LogI',{'tag':tag,'message':message});
  }
}