import 'package:flutter/services.dart';
import 'package:get/get.dart';


class BackController extends GetxController {

  void setOrientation(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    update();
  }

}