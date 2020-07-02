import 'package:get/get.dart';


class OrdersController extends GetxController {

  String date = '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  DateTime dateNotFormated = DateTime(DateTime.now().year, 
    DateTime.now().month,DateTime.now().day, );

  void setDate(DateTime data){
    dateNotFormated = data;
    final String dateFormated = '${data.day}/${data.month}/${data.year}';
    date = dateFormated;
    update();
  }

}