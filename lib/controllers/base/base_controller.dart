import 'package:get/get.dart';


class BaseController extends GetxController {

  int page = 0;
  void setPage(int setPage){
    page = setPage;
    update();
  }
  
}