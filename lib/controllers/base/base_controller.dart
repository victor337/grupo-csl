import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BaseController extends GetxController {

  int page = 0;
  void setPage(int setPage){
    debugPrint('Page atual $page Page que é pra ir $setPage');
    page = setPage;
    update();
  }
  
}