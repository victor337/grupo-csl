import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';


class PhotoBefore implements Bindings {
  @override
  void dependencies() {
    Get.put(PhotoBeforeController(), permanent: true,);
  }
}