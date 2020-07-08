import 'package:get/get.dart';


class StatusController extends GetxController {

  String status;
  void setStatus(String newStatus){
    print(newStatus);
    status = newStatus;
    update();
  }

}