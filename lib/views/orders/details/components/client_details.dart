import 'package:flutter/material.dart';
import 'package:grupocsl/model/order_service/order_service.dart';


class ClientDetails extends StatelessWidget {

  final OrderService orderService;
  const ClientDetails(this.orderService);

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Endereço: ${orderService.adress},'
            ),
            const SizedBox(height: 5,),
            Text(
              'Data do Pedido: ${orderService.dateOrder}',
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