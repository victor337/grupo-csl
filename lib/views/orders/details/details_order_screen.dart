import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/details/components/button_options.dart';
import 'package:grupocsl/views/orders/details/components/checkout_card.dart';
import 'package:grupocsl/views/orders/details/components/client_details.dart';
import 'package:grupocsl/views/orders/details/components/resume_card.dart';
import 'package:grupocsl/views/orders/payment/payment_screen.dart';
import 'package:grupocsl/views/orders/photos/before/photos_before_screen.dart';
import 'package:grupocsl/views/orders/signature/signature_screen.dart';
import 'package:url_launcher/url_launcher.dart';




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
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
        width: sizeScreen.getWidthScreen(context),
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            ResumeCard(orderService),
            const SizedBox(height: 10,),
            ClientDetails(orderService),
            const SizedBox(height: 10,),
            CheckoutCard(orderService),
            const SizedBox(height: 10,),
            ButtonOptions(orderService, index),
            RaisedButton(
              onPressed: (){
                launch(
                  'https://www.google.com/maps/place/${orderService.street}-'
                  '${orderService.city}'
                );
              },
              child: const Text('Abrir no Maps'),
            ),
            RaisedButton(
              onPressed: (){
                Get.to(SignatureScreen());
              },
              child: const Text('Abrir canvas'),
            ),
            RaisedButton(
              onPressed: (){
                Get.to(PaymentScreen(orderService));
              },
              child: const Text('Abrir pagamento'),
            ),
            RaisedButton(
              onPressed: (){
                Get.to(PhotoBeforeScreen());
              },
              child: const Text('Fotos antes'),
            ),
          ],
        ),
      ),
    );
  }

}
