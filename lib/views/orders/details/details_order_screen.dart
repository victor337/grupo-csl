import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/payment/payment_screen.dart';
import 'package:grupocsl/views/orders/photos/before/photos_before_screen.dart';
import 'package:grupocsl/views/orders/signature/signature_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailOrderScreen extends StatefulWidget {

  final OrderService orderService;
  const DetailOrderScreen(this.orderService);

  @override
  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detalhes da OS Nº${widget.orderService.number}',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
        width: sizeScreen.getWidthScreen(context),
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
                width: sizeScreen.getWidthScreen(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Ordem de Serviço: ${widget.orderService.number}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Status: ${widget.orderService.status}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Pago: ${widget.orderService.paid}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Tipo de pagamento: ${widget.orderService.type}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
                width: sizeScreen.getWidthScreen(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Cliente: ${widget.orderService.client}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Telefone: ${widget.orderService.tel}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Celular: ${widget.orderService.phone}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      // ignore: missing_whitespace_between_adjacent_strings
                      'Endereço: ${widget.orderService.adress.street},'
                      // ignore: missing_whitespace_between_adjacent_strings
                      '${widget.orderService.adress.number}, ${widget.orderService.adress.complement??''}'
                      '${widget.orderService.adress.city} - ${widget.orderService.adress.state}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Data do Pedido: ${widget.orderService.date}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Horário: ${widget.orderService.hour}',
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: (){
                launch(
                  'https://www.google.com/maps/place/${widget.orderService.adress.street}+'
                  '${widget.orderService.adress.number}'
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
                Get.to(PaymentScreen(widget.orderService));
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
