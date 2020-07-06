import 'package:get/get.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true,);
  }



}