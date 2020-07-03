import 'package:get/get.dart';


class PaymentController extends GetxController {


  String parcelamentSelected;
  String typeSelected;

  void setParcelament(String parcelament){
    parcelamentSelected = parcelament;
    update();
  }

  void setType(String type){
    typeSelected = type;
    update();
  }
  
  List<String> parcelaments = ['1x', '2x', '3x', '4x', '5x', '6x'];
  List<String> types = ['opção 1', 'opção 2',];

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