import 'package:flutter/material.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailOrderScreen extends StatelessWidget {

  final OrderService orderService;
  DetailOrderScreen(this.orderService);

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detalhes da OS Nº${orderService.number}',
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
                      'Ordem de Serviço: ${orderService.number}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Status: ${orderService.status}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Pago: ${orderService.paid}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Tipo de pagamento: ${orderService.type}',
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
                      'Cliente: ${orderService.client}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Telefone: ${orderService.tel}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Celular: ${orderService.phone}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      // ignore: missing_whitespace_between_adjacent_strings
                      'Endereço: ${orderService.adress.street},'
                      // ignore: missing_whitespace_between_adjacent_strings
                      '${orderService.adress.number}, ${orderService.adress.complement??''}'
                      '${orderService.adress.city} - ${orderService.adress.state}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Data do Pedido: ${orderService.date}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Horário: ${orderService.hour}',
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: (){
                launch(
                  'https://www.google.com/maps/place/${orderService.adress.street}+'
                  '${orderService.adress.number}'
                );
              },
              child: const Text('Abrir no Maps'),
            )
          ],
        ),
      ),
    );
  }
}