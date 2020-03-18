package com.shuyu.gsygithub.gsygithubappflutter

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

class MainActivity(): FlutterActivity() {
  companion object{
    const val FLUTTER_LOG = "android_log"
  }
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    UpdateAlbumPlugin.register(this, flutterView)

    MethodChannel(flutterView, FLUTTER_LOG).setMethodCallHandler { call, result ->
      logPrint(call)
    }
  }

  //日志插件，
  fun logPrint(call:MethodCall){
    val tag: String? = call.argument("tag")!!
    val message:String? = call.argument("message")!!

    when(call.method){

      "LogI" -> android.util.Log.i(tag,message)
    }

  }
}
