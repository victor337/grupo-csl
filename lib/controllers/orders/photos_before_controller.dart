import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class PhotoBeforeController extends GetxController {

  List<PickedFile> images = [];

  void addImage(PickedFile file){
    images.add(file);
    update();
  }

  void removerImage(int index){
    images.removeAt(index);
    update();
  }  
}