import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
 
import 'package:get/get.dart';

class AppConfig {
   
  static ShowLoading({notDisable = (true)}) {
    Get.dialog(
        Container(child: SpinKitThreeBounce(size: 25, color: Colors.white)),
        barrierDismissible: notDisable);
  }
}
