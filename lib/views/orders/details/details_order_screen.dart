import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/details/components/button_options.dart';
import 'package:grupocsl/views/orders/details/components/checkout_card.dart';
import 'package:grupocsl/views/orders/details/components/client_details.dart';
import 'package:grupocsl/views/orders/details/components/observation/observation_screen.dart';
import 'package:grupocsl/views/orders/details/components/resume_card.dart';


class DetailOrderScreen extends StatelessWidget {

  final OrderService orderService;
  final int index;
  DetailOrderScreen(this.orderService, this.index);

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detalhes da OS Nº${orderService.id}',
        ),
        actions: <Widget>[
          GetBuilder<UserController>(
            builder: (userControlller){
              return IconButton(
                icon: Icon(Icons.event_note, color: Colors.white,),
                onPressed: (){
                  Get.to(
                    ObservationScreen(orderService, userControlller.user.token),
                    transition: Transition.zoom,
                    duration: const Duration(milliseconds: 100),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
        width: sizeScreen.getWidthScreen(context),
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            ResumeCard(orderService, index),
            const SizedBox(height: 10,),
            ClientDetails(orderService),
            const SizedBox(height: 10,),
            CheckoutCard(orderService),
            const SizedBox(height: 10,),
            ButtonOptions(orderService, index,),
          ],
        ),
      ),
    );
  }

}
