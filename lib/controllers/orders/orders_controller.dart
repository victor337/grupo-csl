import 'package:get/get.dart';


class OrdersController extends GetxController {

  String date = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  void setDate(String data){
    date = data;
    update();
  }

}