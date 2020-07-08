import 'package:get/get.dart';


class PhotoAfterController extends GetxController {

  List<String> images = [];

  void addImage(String file){
    images.add(file);
    update();
  }

  void removerImage(int index){
    images.removeAt(index);
    update();
  }

  void clearList(){
    images.clear();
    update();
  }
}