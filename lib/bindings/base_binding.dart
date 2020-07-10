import 'package:get/get.dart';
import 'package:grupocsl/controllers/base/base_controller.dart';


class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), permanent: true,);
  }
}