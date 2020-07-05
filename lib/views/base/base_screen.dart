import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/base/base_controller.dart';
import 'package:grupocsl/views/orders/orders_screen.dart';
import 'package:grupocsl/views/profile/profile_screen.dart';


class BaseScreen extends StatelessWidget {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<BaseController>(
          init: BaseController(),
          builder: (baseController){
            if(baseController.page == 0){
              return OrdersScreen();
            } else if(baseController.page == 1){
              return ProfileScreen();
            }
            return Container();
          }
        ),
      ),
    );
  }
}