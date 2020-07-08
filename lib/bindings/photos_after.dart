import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_after_controller.dart';

class PhotosAfter extends Bindings {
  @override
  void dependencies() {
    Get.put(PhotoAfterController(), permanent: true,);
  }

}