import 'package:get/get.dart';


class PhotoBeforeController extends GetxController {

  List<String> images = [];

  void addImage(String file){
    images.add(file);
    update();
  }

  void removerImage(int index){
    images.removeAt(index);
    update();
  }  
}