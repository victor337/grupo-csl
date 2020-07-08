import 'package:flutter/material.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:url_launcher/url_launcher.dart';


class ClientDetails extends StatelessWidget {

  final OrderService orderService;
  const ClientDetails(this.orderService);

  @override
  Widget build(BuildContext context) {

    String setDate(String date){
      final String year = date.substring(0, 4);
      final String month = date.substring(6, 7);
      final String day = date.substring(9, 10);
      return '$day/$month/$year';
    }

    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Cliente: ${orderService.clientName}',
            ),
            const SizedBox(height: 5,),
            Text(
              'Telefone: ${orderService.clientPhone}',
            ),
            const SizedBox(height: 5,),
            Text(
              'Celular: ${orderService.clientCel}',
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Endereço: ${orderService.adress},'
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    launch(
                      'https://www.google.com/maps/place/${orderService.street}-'
                      '${orderService.city}'
                    );
                  },
                  child: const Text(
                    'Ver no mapa',
                    style: TextStyle(
                      color: Colors.blue
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Text(
              'Data do Pedido: ${setDate(orderService.dateOrder)}',
            ),
            const SizedBox(height: 5,),
            Text(
              'Horário: ${orderService.hour}',
            ),
          ],
        ),
      ),
    );
  }
}