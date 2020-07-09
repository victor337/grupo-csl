import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/payment_controller.dart';


class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController(), permanent: true,);
  }
}