import 'package:get/get.dart';


class StatusController extends GetxController {

  String status;
  void setStatus(String newStatus){
    status = newStatus;
    update();
  }

}