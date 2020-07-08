import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/details/components/button_status.dart';
import 'package:url_launcher/url_launcher.dart';


class ButtonOptions extends StatelessWidget {

  final int index;
  final OrderService orderService;
  const ButtonOptions(this.orderService, this.index);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (userController){
        return Row(
          children: <Widget>[
            ButtonStatus(
              onPressed: (status){
                userController.setStatusOrder(
                  token: userController.user.token,
                  os: orderService.id,
                  status: (int.parse(orderService.statusAttendance) + 1).toString(),
                  onFail: (e){
                    Get.snackbar(
                      'Erro',
                      e.title,
                      backgroundColor: Colors.red
                    );
                  },
                  onSucess: (){
                    Get.snackbar(
                      'Sucesso',
                      'Status alterado!',
                      backgroundColor: Colors.green
                    );
                  },
                  index: index
                );
              },
              onAction: (){
                if(int.parse(orderService.status) == 1){
                  launch('https://www.google.com/maps/place/${orderService.street}-'
                  '${orderService.city}');
                }
              },
              setStatus: int.parse(orderService.statusAttendance),
            ),
          ],
        );
      },
    );
  }
}